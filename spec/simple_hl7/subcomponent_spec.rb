require "simple_hl7"

module SimpleHL7
  describe Subcomponent do
    describe "#to_hl7" do
      it "returns the value" do
        subf = Subcomponent.new('test')
        subf.to_hl7(SeparatorCharacters.defaults).should == 'test'
      end

      it "escapes special characters in a string" do
        subc = Subcomponent.new('peas&carrots')
        subc.to_hl7(SeparatorCharacters.defaults).should == 'peas\T\carrots'
      end

      it "escapes all special characters" do
        subc = Subcomponent.new('\\&^~|')
        default_chars = SeparatorCharacters.defaults
        subc.to_hl7(default_chars).should == "\\E\\\\T\\\\S\\\\R\\\\F\\"
      end
    end

    describe "#parse" do
      it "should unescape the special characters" do
        str = "\\E\\\\T\\\\S\\\\R\\\\F\\"
        default_chars = SeparatorCharacters.defaults
        parsed = Subcomponent.parse(str, default_chars)
        parsed.to_s.should == '\\&^~|'
      end
    end
  end
end
