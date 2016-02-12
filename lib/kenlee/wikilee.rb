module KenLee
  class WikiLee < Base
    MAX_PAGE_LIMIT = 10
    ENDPOINT_PREFIX = 'https://{{lang}}.wikipedia.org/w/api.php'
    INTRO_TEMPLATE =
    '{{ep}}?action=query&generator=random&{{rnc}}&grnlimit={{limit}}&' +
    'grnnamespace=0&prop=extracts&exlimit={{limit}}&exintro&explaintext&' +
    'format=json'

    attr_reader :endpoint

    def initialize(lang = :en)
      @endpoint = ENDPOINT_PREFIX.gsub("{{lang}}", lang.to_s)
      @rnc = nil
      @paragraphs = []
    end

    def paragraph
      fetch_paragraph
    end

    def paragraphs(nr = 10)
      result = []
      (1..nr).each { result << fetch_paragraph }
      result
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
        .gsub("{{ep}}", @endpoint)
        .gsub("{{rnc}}", @rnc.nil? ? "grncontinue=#{@rnc}" : '')
        .gsub("{{limit}}", MAX_PAGE_LIMIT)
      http = Curl.get(url)
      puts http.body_str
    end

  end
end