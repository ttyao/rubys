require 'spec_helper'

describe "StaticPages" do

  subject {page}

  shared_examples_for "all static pages" do
    it {should have_content heading}
    it {should have_title(full_title(page_title))}
  end

  describe "Home Page" do
    before {visit root_path}
    let(:heading) {"Sample App"}
    let(:page_title) {''}
    it_should_behave_like "all static pages"

    it { should_not have_title '| Home'}
  end

  describe "About page" do
    before {visit about_path}
    let(:heading) {"About"}
    let(:page_title) {''}
    it_should_behave_like "all static pages"
  end

end
