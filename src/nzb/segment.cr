require "json"

class Nzb
  class Segment
    property bytes : Int64
    property number : Int64
    property text : String

    JSON.mapping(
      bytes: Int64,
      number: Int64,
      text: String,
    )

    def initialize(@bytes, @number, @text); end

    def to_xml(xml)
      xml.element("segment", bytes: bytes.to_s, number: number.to_s) { xml.text text }
    end

    def self.from_xml(xml) : Segment
      Segment.new(
        xml["bytes"].to_i64,
        xml["number"].to_i64,
        xml.content,
      )
    end
  end
end
