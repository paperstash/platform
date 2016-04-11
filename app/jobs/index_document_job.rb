class PaperStash
  class IndexDocumentJob < PaperStash::Job
    def perform(type, id)
      doc = type.constantize[id]
      # TODO(mtwilliams): Index documents for full-text search.
      raise "No implemented, yet."
    end
  end
end
