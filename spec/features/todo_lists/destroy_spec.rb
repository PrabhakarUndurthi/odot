require 'spec_helper'

describe "Deleting todo lists" do
  let!(:todo_list) {TodoList.create(title: "Groceries", description: "My Groceries list")}

  it "is successfull when clicking on the delete link" do
    visit "/todo_lists"

    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end

    expect(page).to_not eq(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
