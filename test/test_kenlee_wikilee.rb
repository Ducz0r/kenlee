require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestKenLeeWikiLee < Test::Unit::TestCase

  def setup
    @wl = KenLee::WikiLee.new(:en)
  end

  def test_endpoint
    assert @wl.endpoint.start_with? 'https://en.wikipedia.org/w/api.php'
  end

  def test_paragraph
    paragraph = @wl.paragraph
    assert_paragraph(paragraph)
  end

  def test_paragraphs
    paragraphs = @wl.paragraphs(15)
    assert !paragraphs.nil?
    assert paragraphs.is_a? Array
    paragraphs.each do |paragraph|
      assert_paragraph(paragraph)
    end
  end

  private

  def assert_paragraph(paragraph)
    assert !paragraph.nil?
    assert paragraph.is_a? String
  end

end