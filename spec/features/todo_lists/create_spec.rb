require 'spec_helper'


describe "Creating todos" do
  def create_todo_list(options={})
    options[:title] ||= "my todo list"
    options[:description] ||= "I am going to buy groceries today"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end


  it "redirects to the index page on success" do
    create_todo_list

    expect(page).to have_content("my todo list")
  end

  it "displays an error if the todo_list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)


    visit "/todo_lists"
    expect(page).to_not have_content("I am going to buy groceries today")
  end

  it "title must be more than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("I am going to buy groceries today")
  end

  it "desciption can not be blank" do
    expect(TodoList.count).to eq(0)

    create_todo_list  title: "grocery list", description:""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("my todo list")
  end

  it "description must be more than 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "grocery list", description: "less"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Grocery list")
  end
end
