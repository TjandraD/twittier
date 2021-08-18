# frozen_string_literal: true

require_relative '../models/hashtag'

class HashtagController
  def trending_hashtags
    trending_hashtags = Hashtag.trending_hashtags

    {
      'hashtags' => trending_hashtags.each
    }
  end
end
