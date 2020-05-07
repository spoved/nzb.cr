class Nzb
  class File
    property poster : String
    property date : Time
    property subject : String
    property groups : Array(String) = Array(String).new
    property segments : Array(Segment) = Array(Segment).new

    def initialize(@poster, @date, @subject, @groups, @segments); end

    def to_xml(xml)
      xml.element("file", poster: poster, date: date.to_unix.to_s, subject: subject) do
        xml.element("groups") { groups.each { |group| xml.element("group") { xml.text group } } }
        xml.element("segments") { segments.each &.to_xml(xml) }
      end
    end
  end
end
