module ApplicationHelper
   def render_with_hashtags(introduction)
     if customer_signed_in?
        introduction.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post/hashtag/#{word.delete("#")}"}.html_safe
     else
        introduction.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/admin/post/hashtag/#{word.delete("#")}"}.html_safe
     end
   end
end
