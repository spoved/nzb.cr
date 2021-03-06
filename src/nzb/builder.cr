class Nzb::Builder
  getter nzb_filename : String
  private property nzb : Nzb

  # we accept basename and prefix, combine them and add suffix ".nzb"
  def initialize(filename : String, prefix = "")
    @nzb_filename = prefix + filename + ".nzb"
    @nzb = Nzb.new
  end

  def initialize(@nzb)
    @nzb_filename = "#{@nzb.name}.nzb"
  end

  def self.build(filename, prefix = "", &block)
    Nzb::Builder.new(filename, prefix).build do |nzb|
      yield nzb
    end
  end

  def build(&block)
    yield nzb
  end

  def to_xml
    self.get_xml
  end

  protected def get_xml
    XML.build(indent: "  ", version: "1.0", encoding: "UTF-8") do |xml|
      xml.dtd(name: "nzb", pubid: "-//newzBin//DTD NZB 1.1//EN", sysid: "http://www.newzbin.com/DTD/nzb/nzb-1.1.dtd") { }
      xml.element("nzb", xmlns: "http://www.newzbin.com/DTD/2003/nzb") do
        gen_header(xml)
        gen_files(xml)

        xml.comment "generated by nzb.cr #{Nzb::VERSION}"
      end
    end
  end

  def write
    content = self.get_xml

    ::File.open(@nzb_filename, "w", encoding: "UTF-8") do |file|
      file.puts content
    end
  end

  # Generate headers
  protected def gen_header(xml)
    xml.element("head") do
      xml.element("meta", type: "name") { xml.text nzb.name.as(String) } unless nzb.name.nil?
      xml.element("meta", type: "category") { xml.text nzb.category.as(String) } unless nzb.category.nil?

      nzb.metadata.each do |k, v|
        xml.element("meta", type: k) { xml.text v }
      end
    end
  end

  protected def gen_files(xml)
    nzb.files.each &.to_xml(xml)
  end
end
