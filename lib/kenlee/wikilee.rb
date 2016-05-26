module KenLee
  class WikiLee < Base
    require 'curb'
    require 'json'

    MAX_PAGE_LIMIT = 10
    ENDPOINT_PREFIX = 'https://{{lang}}.wikipedia.org/w/api.php'
    INTRO_TEMPLATE =
    '{{ep}}?action=query&generator=random&{{rnc}}&grnlimit={{limit}}&' +
    'grnnamespace=0&prop=extracts&exlimit={{limit}}&exintro&explaintext&' +
    'format=json'

    attr_reader :endpoint

    def initialize(lang = :en)
      @endpoint = ENDPOINT_PREFIX.gsub('{{lang}}', lang.to_s)
      @rnc = nil
      @paragraphs = []
    end

    def paragraph
      fetch_paragraph
    end

    def paragraphs(nr = 10)
      (1..nr).collect { fetch_paragraph }
    end

    private

    def fetch_paragraph
      if @paragraphs.empty? then
        query_paragraphs
      end
      @paragraphs.pop
    end

    def query_paragraphs
      url = INTRO_TEMPLATE
      url = url.gsub('{{ep}}', @endpoint)
      url = url.gsub('{{rnc}}', @rnc.nil? ? '' : "grncontinue=#{@rnc}")
      url = url.gsub('{{limit}}', "#{MAX_PAGE_LIMIT}")
      http = Curl.get(url)
      json = JSON.parse(http.body_str)

      @rnc = (json.has_key? "continue") ? json["continue"]["grncontinue"] : nil
      if json.has_key? "query"
        json["query"]["pages"].values.each do |page|
          @paragraphs.push(page["extract"])
        end
      else
        raise Exception # TODO
      end
    end

  end
end