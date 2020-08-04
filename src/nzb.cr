require "xml"
require "json_mapping"

class Nzb
  property name : String? = nil
  property category : String? = nil
  property metadata : Hash(String, String) = Hash(String, String).new
  getter files : Array(Nzb::File) = [] of Nzb::File

  JSON.mapping(
    name: String?,
    category: String?,
    metadata: Hash(String, String),
    files: Array(Nzb::File),
  )

  def initialize
  end

  def from_xml(xml : XML::Node) : Nzb
    xml.children.each do |child|
      next unless child.element?
      case child.name
      when "head"
        parse_head_node child
      when "file"
        parse_file_node child
      else
        raise "Unknown xml object: #{child.name}"
      end
    end
    self
  end

  private def parse_head_node(xml)
    xml.children.each do |c|
      if c.name == "meta"
        next unless c["type"]?
        case c["type"]
        when "name"
          self.name = c.content
        when "category"
          self.category = c.content
        else
          self.metadata[c["type"]] = c.content
        end
      end
    end
  end

  private def parse_file_node(xml)
    files << Nzb::File.from_xml(xml)
  end

  def self.from_xml(xml)
    nzb = xml.first_element_child
    raise "Unable to parse nzb xml" if nzb.nil?
    raise "Invalid xml" if nzb.name != "nzb"
    Nzb.new.from_xml(nzb)
  end

  def self.open(filepath : String)
    contents = ::File.read(filepath)
    xml = XML.parse(contents)
    from_xml(xml)
  end

  def to_xml
    Nzb::Builder.new(self).to_xml
  end
end

require "./nzb/*"
