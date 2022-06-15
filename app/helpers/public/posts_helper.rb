module Public::PostsHelper
  def render_with_hashtags(introduction)
    introduction.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post/hashtag/#{word.delete("#")}"}.html_safe
  end
end
