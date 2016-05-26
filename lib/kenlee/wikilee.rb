module KenLee
  class WikiLee < Base
    require 'curb'
    require 'json'

    MAX_PAGE_LIMIT = 10
    ENDPOINT_PREFIX = 'https://{{lang}}.wikipedia.org/w/api.php'
    MAIN_TEMPLATE =
    '{{ep}}?action=query&generator=random&{{rnc}}&grnlimit={{limit}}&' +
    'grnnamespace=0&prop={{prop}}&{{prop_params}}&' +
    'format=json'

    attr_reader :endpoint

    def initialize(lang = :en)
      @endpoint = ENDPOINT_PREFIX.gsub('{{lang}}', lang.to_s)
      @rnc = nil
      @extracts = []
      @links = []
      @links_continue = nil
    end

    def extract
      get_single_extract
    end

    def extracts(nr = 10)
      (1..nr).collect { get_single_extract }
    end

    def link
      get_single_link
    end

    def links(nr = 10)
      (1..nr).collect { get_single_link }
    end

    private

    def get_data_json(prop, prop_params = nil)
      if prop_params.nil? || prop_params.empty?
        prop_params_str = ''
      else
        prop_params_str = prop_params.collect{|k,v| v.nil? ? "#{k}" : "#{k}=#{v}"}.join('&')
      end

      url = MAIN_TEMPLATE
      url = url.gsub('{{ep}}', @endpoint)
      url = url.gsub('{{rnc}}', @rnc.nil? ? '' : "grncontinue=#{@rnc}")
      url = url.gsub('{{limit}}', "#{MAX_PAGE_LIMIT}")
      url = url.gsub('{{prop}}', prop)
      url = url.gsub('{{prop_params}}', prop_params_str)
      http = Curl.get(url)
      JSON.parse(http.body_str)
    end

    def get_single_extract
      if @extracts.empty? then
        fetch_extracts
      end
      @extracts.pop
    end

    def fetch_extracts
      json = get_data_json('extracts', { 'exlimit' => MAX_PAGE_LIMIT, 'exintro' => nil, 'explaintext' => nil })

      @rnc = (json.has_key? 'continue') ? json['continue']['grncontinue'] : nil
      if json.has_key? 'query'
        json['query']['pages'].values.each do |page|
          @extracts.push(page['extract'])
        end
      else
        raise Exception, 'Invalid JSON received from Wikimedia API'
      end
    end

    def get_single_link
      if @links.empty? then
        fetch_links
      end
      @links.pop
    end

    def fetch_links
      prop_params = { 'ellimit' => MAX_PAGE_LIMIT }
      unless @links_continue.nil?
        prop_params['eloffset'] = @links_continue
      end
      json = get_data_json('extlinks', prop_params)

      @links_continue = (json.has_key? 'continue') ? json['continue']['eloffset'] : nil
      if json.has_key? 'query'
        json['query']['pages'].values.each do |page|
          if page.has_key? 'extlinks'
            page['extlinks'].each do |link_map|
              @links.push(link_map['*'])
            end
          end
        end
      else
        raise Exception, 'Invalid JSON received from Wikimedia API'
      end
    end

  end
end