class PaperStash
  class GenerateThumbnailJob < PaperStash::Job
    # TODO(mtwilliams): Generate thumbnails of varying sizes?
    SIZE = [256, 256]

    def perform(type, id)
      doc = type.constantize[id]
      doc.thumbnail = upload(thumbnail_from_cover(cover_from_doc(doc.pdf)))
      doc.save
    end

    private
      def cover_from_doc(doc)
        (Magick::ImageList.new("#{doc}[1]") do
          self.density = 300
          self.colorspace = Magick::RGBColorspace
          self.interlace = Magick::NoInterlace
        end).cur_img
      end

      def thumbnail_from_cover(cover)
        width, height = *SIZE
        cover.resize_to_fill(width, height)
      end

      def upload(thumbnail)
        path = "thumbnails/#{SecureRandom.uuid}.png"
        PaperStash.s3.objects[path].write(thumbnail.to_blob, :acl => :public_read)
        "http://#{ENV['CDN']}/#{path}"
      end
  end
end
