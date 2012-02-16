module HamlHelper
# Haml helper to create a naive hierarchy of dl/dt/dd for any xml node
  def xml_to_dl(node)
    haml_tag('dl') do
      node.elements.each do |n|
        haml_tag('dt', n.name)
        if n.elements.empty?
          haml_tag('dd', n.text)
        else
          haml_tag('dd') { xml_to_dl(n) }
        end
      end
    end
  end
end