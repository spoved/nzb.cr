class Nzb
  class File
    property poster : String
    property date : Time
    property subject : String
    property groups : Array(String) = Array(String).new
    property segments : Array(Segment) = Array(Segment).new

    def initialize(@poster, @date, @subject,
                   @groups = Array(String).new, @segments = Array(Segment).new); end

    def to_xml(xml)
      xml.element("file", poster: poster, date: date.to_unix.to_s, subject: subject) do
        xml.element("groups") { groups.each { |group| xml.element("group") { xml.text group } } }
        xml.element("segments") { segments.each &.to_xml(xml) }
      end
    end

    def self.from_xml(xml) : File
      poster = xml["poster"]
      date = Time.unix(xml["date"].to_i)
      subject = xml["subject"]

      file = File.new(poster, date, subject)
      xml.children.each do |child|
        next unless child.element?

        case child.name
        when "groups"
          child.children.each do |c|
            next unless c.element?
            file.groups << c.content if c.name == "group"
          end
        when "segments"
          child.children.each do |c|
            next unless c.element?
            file.segments << Segment.from_xml(c) if c.name == "segment"
          end
        else
          raise "Unknown xml object: #{child.name} in #{xml.name}"
        end
      end
      file
    end
  end
end
