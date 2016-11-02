#! ruby -Ku

=begin
 2016/11/02
 
 テキストをkokia語にして返すスクリプト
=end


##########################################################################################
#特に指定がなかったら、全部入りのconfigを使う

#共通の部分

require "net/ftp"
require "fileutils"
require "CSV"
require "json"
##########################################################################################

#とりあえず、ひらがな対応
Dictionary_kokia_go = {"あ" => "a", "い" => "i", "う" => "u", "え" => "e", "お" => "o", "か" => "ka", "き" => "ki", "く" => "ku", "け" => "ke", "こ" => "ko", "さ" => "sa", "し" => "shi", "す" => "su", "せ" => "se", "そ" => "so", "た" => "ta", "ち" => "chi", "つ" => "tsu", "て" => "te", "と" => "to", "な" => "na", "に" => "ni", "ぬ" => "nu", "ね" => "ne", "の" => "no", "は" => "ha", "ひ" => "hi", "ふ" => "fu", "へ" => "he", "ほ" => "ho", "ま" => "ma", "み" => "mi", "む" => "mu", "め" => "me", "も" => "mo", "や" => "ya", "ゆ" => "yu", "よ" => "yo", "ら" => "ra", "り" => "ri", "る" => "ru", "れ" => "re", "ろ" => "ro", "わ" => "wa", "ゐ" => "wi", "ゑ" => "we", "を" => "wo", "ん" => "n", "が" => "ga", "ぎ" => "gi", "ぐ" => "gu", "げ" => "ge", "ご" => "go", "ざ" => "za", "じ" => "ji", "ず" => "zu", "ぜ" => "ze", "ぞ" => "zo", "だ" => "da", "ぢ" => "di", "づ" => "du", "で" => "de", "ど" => "do", "ば" => "ba", "び" => "bi", "ぶ" => "bu", "べ" => "be", "ぼ" => "bo", "ぱ" => "pa", "ぴ" => "pi", "ぷ" => "pu", "ぺ" => "pe", "ぽ" => "po", "ぁ" => "la", "ぃ" => "li", "ぅ" => "lu", "ぇ" => "le", "ぉ" => "lo", "っ" => "ltsu", "ゃ" => "lya", "ゅ" => "lyo", "ょ" => "lyo", "　" => " ", "ー" => "-"}

#KOKIA語変換
def kokia_go_generater(text)
	temp_text = text.reverse
	
	#あんま長くなりすぎそうだったら、文字数見て制限するかも
	#text_length = text.length
	#p "テキスト：#{text_length}文字"
	
	output = Array.new
	#文字列を繰り返したい場合は、eachじゃできなくなってる。chars使う
	temp_text.chars do |moji|
		#変換できない文字はそのままぶっこむ
		if Dictionary_kokia_go[moji].nil?
			output << moji
		else
			output << Dictionary_kokia_go[moji]
		end
	end
	
	return output.join
end

#実行時の引数で読むconfigファイルを変える
path = ARGV[0]

#引数がなかったら、そこでやめる
if path == nil then
	p "引数指定無し"
	exit
end

#パスが存在しなくてもそこでやめる
if !File.exist?(path)
	p "パスのファイルが見つからない"
	exit
end

text = File.read(path)

print kokia_go_generater(text), "\n"
