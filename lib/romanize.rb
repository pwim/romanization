module Romanize
  def mapping
    vowels = %w[a i u e o]
    mapping = {}
    [
      ("ぁ".."お").to_a,
    ].each do |a|
      vowels.each_with_index do |e,i|
        mapping[a[i*2]] = e
        mapping[a[i*2+1]] = e
      end
    end

    [
      [("か".."ご"), "kg"],
      [("さ".."ぞ"), "sz"],
      [("た".."ど").to_a - ["っ"], "td"],
      [("な".."の"), "n"],
      [("は".."ぽ"), "hbp"],
      [("み".."も"), "m"],
      [("ら".."ろ"), "r"],
    ].each do |a, b|
      a.each_with_index do |e,i|
        mapping[e] = b[i%b.size] + vowels[i/b.size]
      end
    end

    mapping["ゃ"] = mapping["や"] = "ya"
    mapping["ゅ"] = mapping["ゆ"] = "yu"
    mapping["ょ"] = mapping["よ"] = "yo"
    mapping["わ"] = "wa"
    mapping["ゐ"] = "wi"
    mapping["を"] = "wo"
    mapping["ん"] = "n"
    mapping
  end

  def romanize(s)
    result = ""
    chars = s.chars
    chars.each_with_index do |c, i|
      next_char = chars[i+1]
      if next_char && "ゃゅょ".include?(next_char)
        result << mapping[c][0,1]
      elsif next_char && c == "っ"
        result << mapping[next_char][0,1]
      else
        result << mapping[c]
      end
    end
    result
  end
end
