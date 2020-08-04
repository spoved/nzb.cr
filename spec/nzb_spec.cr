require "./spec_helper"

describe Nzb do
  it "writes base nzb" do
    Nzb::Builder.new("spec/files/test").write
    file_path = "spec/files/test.nzb"
    File.exists?(file_path).should be_true
    FileUtils.rm(file_path)
  end

  it "can be read from file" do
    nzb = Nzb.open(EXAMPLE_NZB)
    nzb.name.should eq "2kGiFqHLaYfIBPbtk1CPsDsdDJubu4"
    nzb.category.should eq "Other > Misc"
    nzb.files.should_not be_empty
    nzb.files.size.should eq 5
  end

  it "contents can be retrieved" do
    nzb = Nzb.open(EXAMPLE_NZB)
    nzb.to_xml.should_not be_empty
    puts nzb.to_xml
  end
end
