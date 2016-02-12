require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestKenLeeWikiLee < Test::Unit::TestCase

  def setup
    @wl = KenLee::WikiLee.new(:en)
  end

  def test_endpoint
    assert @wl.endpoint.start_with? 'https://en.wikipedia.org/w/api.php'
  end

  def test_paragraph
    puts @wl.paragraph
    assert @wl.paragraph.present?
  end

  def test_paragraphs
    puts @wl.paragraphs(15)
  end

end