describe TodoList do
  before(:each) { @todo_list = TodoList.new(name: 'Lorem ipsum') }

  subject { @todo_list }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@todo_list.name).to match 'Lorem ipsum'
  end
end
