require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestKenLeeWikiLee < Test::Unit::TestCase

  def setup
    @wl = KenLee::WikiLee.new(:en)
  end

  def test_endpoint
    assert @wl.endpoint.start_with? 'https://en.wikipedia.org/w/api.php'
  end

  def test_extract
    extract = @wl.extract
    assert_extract(extract)
  end

  def test_extracts
    extracts = @wl.extracts(15)
    assert !extracts.nil?
    assert extracts.is_a? Array
    extracts.each do |extract|
      assert_extract(extract)
    end
  end

  def test_link
    link = @wl.link
    assert_link(link)
  end

  def test_links
    links = @wl.links(15)
    assert !links.nil?
    assert links.is_a? Array
    links.each do |link|
      assert_link(link)
    end
  end

  private

  def assert_extract(extract)
    assert !extract.nil?
    assert extract.is_a? String
  end

  def assert_link(link)
    assert !link.nil?
    assert link.is_a? String
  end

end