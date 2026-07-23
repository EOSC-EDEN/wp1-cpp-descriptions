# frozen_string_literal: true

require 'rexml/document'

relations_file = File.join(File.dirname(__FILE__), 'relations.xml')
relations_xml = File.read(relations_file)
relations_doc = REXML::Document.new(relations_xml)

cpps_file = File.join(File.dirname(__FILE__), 'cpps.xml')
cpps_xml = File.read(cpps_file)
cpps_doc = REXML::Document.new(cpps_xml)

relationships = {}

cpps_doc.elements.each('//cpp') do |cpp|
  cpp_id = cpp.attributes['identifier']
  relationships[cpp_id] = {}

  cpp_file = File.join(File.dirname(__FILE__), "#{cpp_id}", "#{cpp_id.downcase}.xml")
  cpp_xml = File.read(cpp_file)
  cpp_doc = REXML::Document.new(cpp_xml)

  relations_doc.elements.each('//relation') do |relation|

    relation_id = relation.attributes['identifier']
    node = relation.elements['node']&.text

    related_cpp_ids = node ? REXML::XPath.match(cpp_doc, node).map {|n| n.to_s} : []

    relationships[cpp_id][relation_id] = related_cpp_ids.sort.uniq
  end
end

# Sanity check

discrepancies = []

relationships.each do |cpp_id, relations|
  relations.each do |relation_id, related_cpp_ids|
    related_cpp_ids.each do |related_cpp_id|
      unless relationships.key?(related_cpp_id)
        discrepancies << { cpp_id: cpp_id, relation_id: relation_id, related_cpp_id: related_cpp_id }
      end
      # Check inverse relation
      inverse_relation_id = relations_doc.elements["//relation[@identifier='#{relation_id}']/inverse_of"]&.text
      if inverse_relation_id
        if inverse_relation_id == relation_id
          # Self-referential relation
          unless relationships[related_cpp_id][relation_id]&.include?(cpp_id)
            discrepancies << { cpp_id: cpp_id, relation_id: relation_id, related_cpp_id: related_cpp_id, type: :symmetry }
          end
        else
          inverse_relation = relations_doc.elements["//relation[@identifier='#{inverse_relation_id}']"]
          inverse_node = inverse_relation&.elements['node']&.text
          if inverse_node
            inverse_related_cpp_ids = relationships[related_cpp_id][inverse_relation_id] rescue []
            unless inverse_related_cpp_ids.include?(cpp_id)
              discrepancies << { cpp_id: cpp_id, relation_id: relation_id, related_cpp_id: related_cpp_id, inverse_relation_id: inverse_relation_id, type: :reciprocal }
            end
          else
            # inverse relationship needs to be generated
            relationships[related_cpp_id][inverse_relation_id] ||= []
            unless relationships[related_cpp_id][inverse_relation_id].include?(cpp_id)
              relationships[related_cpp_id][inverse_relation_id] << cpp_id
            end
          end
        end
      end
    end
  end
end

# output discrepancies
File.open('relation_discrepancies.txt', 'w') do |file|
  if discrepancies.empty?
    file.puts "No discrepancies found."
  else
    file.puts "Discrepancies found:"
    discrepancies.group_by { |issue| issue[:cpp_id] }.sort_by { |k,v| k }.each do |cpp_id, issues|
      file.puts "  Found in #{cpp_id}:"
      issues.sort_by { |issue| issue[:inverse_relation_id] || issue[:relation_id] }.each do |issue|
        inverse_relation_id = issue[:inverse_relation_id] || issue[:relation_id]
        file.puts "    #{issue[:cpp_id]} --#{issue[:relation_id]}--> #{issue[:related_cpp_id]} (missing: #{issue[:related_cpp_id]} --#{inverse_relation_id}--> #{issue[:cpp_id]})"
      end
    end
  end
end

# ouput discrepancies, but this time by related_cpp_id
File.open('relation_discrepancies_inversed.txt', 'w') do |file|
  if discrepancies.empty?
    file.puts "No discrepancies found."
  else
    file.puts "Discrepancies found (grouped by related_cpp_id):"
    discrepancies.group_by { |issue| issue[:related_cpp_id] }.sort_by { |k,v| k }.each do |related_cpp_id, issues|
      file.puts "  Missing in #{related_cpp_id}:"
      issues.sort_by { |issue| issue[:inverse_relation_id] || issue[:relation_id] }.each do |issue|
        inverse_relation_id = issue[:inverse_relation_id] || issue[:relation_id]
        file.puts "    #{related_cpp_id} --#{inverse_relation_id}--> #{issue[:cpp_id]} (from: #{issue[:cpp_id]} --#{issue[:relation_id]}--> #{related_cpp_id})"
      end
    end
  end
end

# Output the relationships hash to a file
require 'json'
File.write('relations.json', JSON.pretty_generate(relationships))
puts "Relationships have been written to relations.json"
