shared_examples_for 'a Channel' do

  it 'responds to #handle_event' do
    should respond_to(:handle_event).with(1).argument
  end

end
