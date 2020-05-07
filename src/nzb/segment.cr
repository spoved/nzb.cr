class Nzb
  class Segment
    property bytes : Int64
    property number : Int64
    property text : String

    def initialize(@bytes, @number, @text); end

    def to_xml(xml)
      xml.element("segment", bytes: bytes.to_s, number: number.to_s) { xml.text text }
    end
  end
end
