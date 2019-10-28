module Languages
  class Persistence
    attr_reader :account

    def initialize(account)
      @account = account
    end

    def create(params)
      language = account.languages.create(params)

      language
    end

    def update(params)
      language = account.languages.find_by(uuid: params.delete(:id))
      language.update(params)

      language
    end
  end
end
