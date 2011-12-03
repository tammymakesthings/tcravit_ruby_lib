describe "TcravitRubyLib::Utility" do
  it "random_alphanumeric() should return a random string of the correct length" do
    s = TcravitRubyLib::Utility.random_alphanumeric(16)
    s.should_not be_nil
    s.length.should == 16
    s.should match(/^[A-Za-z0-9]+$/)
  end
end