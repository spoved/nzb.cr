require "json_mapping"

class Nzb
  class Segment
    property bytes : Int64
    property number : Int64
    property text : String
    property metadata : Hash(String, String) = Hash(String, String).new

    JSON.mapping(
      bytes: Int64,
      number: Int64,
      text: String,
      metadata: Hash(String, String),
    )

    def initialize(@bytes, @number, @text, @metadata = Hash(String, String).new); end

    def to_xml(xml)
      xml.element("segment", bytes: bytes.to_s, number: number.to_s) do
        unless metadata.empty?
          xml.element("metadata") do
            metadata.each do |k, v|
              xml.element("meta", type: k) { xml.text v }
            end
          end
        end
        xml.text text
      end
    end

    def self.from_xml(xml) : Segment
      seg = Segment.new(
        xml["bytes"].to_i64,
        xml["number"].to_i64,
        xml.content,
      )

      xml.children.each do |child|
        next unless child.element?
        case child.name
        when "metadata"
          child.children.each do |m|
            next if !m.element? || m.name != "meta"
            seg.metadata[m["type"]] = m.content
          end
        end
      end

      seg
    end
  end
end
