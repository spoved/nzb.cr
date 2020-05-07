require "./spec_helper"

describe Nzb do
  # TODO: Write tests

  it "writes base nzb" do
    Nzb.new("spec/files/test").write_nzb
    file_path = "spec/files/test.nzb"
    File.exists?(file_path).should be_true
    xml = File.read(file_path)
    document = XML.parse(xml) # : XML::Node
    puts document

    FileUtils.rm(file_path)
  end
end
