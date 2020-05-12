# frozen_string_literal: true

require 'thamble'

verbs = [["会う","あう","godan",["to meet","to encounter","to see"]],["上がる","あがる","godan",["to rise","to go up","to come up","to ascend","to be raised"]],["開く","あく","godan",["to open","to undo","to unseal","to unpack"]],["開ける","あける","ichidan",["to open (a door, etc.)","to unwrap (e.g. parcel, package)","to unlock"]],["上げる","あげる","ichidan",["to raise","to elevate"]],["遊ぶ","あそぶ","godan",["to play","to enjoy oneself","to have a good time"]],["温める","あたためる","ichidan",["to warm","to heat"]],["当たる","あたる","godan",["to be hit","to strike"]],["集まる","あつまる","godan",["to gather","to collect","to assemble"]],["集める","あつめる","ichidan",["to collect","to assemble","to gather"]],["当てる","あてる","ichidan",["to hit"]],["浴びる","あびる","ichidan",["to dash over oneself (e.g. water)","to take (e.g. shower)","to bask in (e.g. the sun)","to bathe in","to be flooded with (e.g. light)","to be covered in"]],["謝る","あやまる","godan",["to apologize","to apologise"]],["争う","あらそう","godan",["to compete","to contest","to contend"]],["表す","あらわす","godan",["to represent","to signify","to stand for"]],["有る","ある","godan",["to be","to exist","to live"]],["歩く","あるく","godan",["to walk"]],["合わせる","あわせる","ichidan",["to match (rhythm, speed, etc.)"]],["言う","いう","godan",["to say","to utter","to declare"]],["生きる","いきる","ichidan",["to live","to exist"]],["行く","いく","godan",["to go","to move (in a direction or towards a specific location)","to head (towards)","to be transported (towards)","to reach"]],["居る","いる","ichidan",["to be (of animate objects)","to exist"]],["要る","いる","godan",["to be needed","to be wanted"]],["入れる","いれる","ichidan",["to put in","to let in","to take in","to bring in","to insert","to install (e.g. software)","to set (a jewel, etc.)","to ink in (e.g. tattoo)"]],["植える","うえる","ichidan",["to plant","to grow","to raise"]],["受ける","うける","ichidan",["to receive","to get"]],["動かす","うごかす","godan",["to move","to shift","to stir","to budge","to change position"]],["動く","うごく","godan",["to move","to stir","to shift","to shake","to swing"]],["失う","うしなう","godan",["to lose"]],["歌う","うたう","godan",["to sing"]],["打つ","うつ","godan",["to hit","to strike","to knock","to beat","to punch","to slap","to tap","to bang","to clap","to pound"]],["写す","うつす","godan",["to transcribe","to duplicate","to reproduce","to imitate","to trace"]],["写る","うつる","godan",["to be photographed","to be projected"]],["生まれる","うまれる","ichidan",["to be born"]],["生む","うむ","godan",["to give birth","to bear (child)","to lay (eggs)"]],["売る","うる","godan",["to sell"]],["売れる","うれる","ichidan",["to sell (well)"]],["選ぶ","えらぶ","godan",["to choose","to select"]],["追いかける","おいかける","ichidan",["to chase","to run after","to pursue"]],["追い付く","おいつく","godan",["to catch up (with)","to draw level","to pull even","to reach"]],["追う","おう","godan",["to chase","to run after","to pursue","to follow after"]],["起きる","おきる","ichidan",["to get up","to rise","to blaze up (fire)"]],["送る","おくる","godan",["to send (a thing)","to dispatch","to despatch","to transmit"]],["遅れる","おくれる","ichidan",["to be late","to be delayed","to fall behind schedule","to be overdue","to fall behind"]],["起こす","おこす","godan",["to raise","to raise up","to set up","to pick up"]],["行う","おこなう","godan",["to perform","to do","to conduct oneself","to carry out"]],["起こる","おこる","godan",["to occur","to happen"]],["教える","おしえる","ichidan",["to teach","to instruct"]],["押す","おす","godan",["to push","to press"]],["落ち着く","おちつく","godan",["to calm down","to compose oneself","to regain presence of mind"]],["落ちる","おちる","ichidan",["to fall down","to drop","to fall (e.g. rain)","to sink (e.g. sun or moon)","to fall onto (e.g. light or one's gaze)","to be used in a certain place (e.g. money)"]],["落とす","おとす","godan",["to drop","to lose","to let fall","to shed (light)","to cast (one's gaze)","to pour in (liquid)","to leave behind"]],["踊る","おどる","godan",["to dance (orig. a hopping dance)"]],["覚える","おぼえる","ichidan",["to memorize","to memorise","to commit to memory","to learn by heart","to bear in mind","to remember"]],["思い出す","おもいだす","godan",["to recall","to remember","to recollect"]],["思う","おもう","godan",["to think","to consider","to believe","to reckon"]],["泳ぐ","およぐ","godan",["to swim"]],["折る","おる","godan",["to break","to fracture","to break off","to snap off","to pick (e.g. flowers)"]],["終わる","おわる","godan",["to finish","to end","to close"]],["買う","かう","godan",["to buy","to purchase"]],["返す","かえす","godan",["to return (something)","to restore","to put back"]],["代える","かえる","ichidan",["to replace"]],["返る","かえる","godan",["to return","to come back","to go back"]],["変える","かえる","ichidan",["to change","to alter","to transform","to convert","to turn","to vary"]],["欠かす","かかす","godan",["to miss (doing)","to fail (to do)"]],["書く","かく","godan",["to write","to compose","to pen"]],["欠ける","かける","ichidan",["to be chipped","to be damaged","to be broken"]],["囲む","かこむ","godan",["to surround","to encircle","to enclose","to fence","to wall in"]],["飾る","かざる","godan",["to decorate","to ornament","to adorn"]],["化す","かす","godan",["to change into","to convert to","to transform","to be reduced","to influence","to improve (someone)"]],["数える","かぞえる","ichidan",["to count","to enumerate"]],["片付ける","かたづける","ichidan",["to tidy up","to put in order","to straighten up","to put away"]],["語る","かたる","godan",["to talk about","to speak of","to tell","to narrate"]],["勝つ","かつ","godan",["to win","to gain victory"]],["通う","かよう","godan",["to go to and from (a place)","to go back and forth between","to run between (e.g. bus, train, etc.)","to ply between"]],["借りる","かりる","ichidan",["to borrow","to have a loan"]],["代わる","かわる","godan",["to succeed","to relieve","to replace"]],["考える","かんがえる","ichidan",["to think (about, of)","to think over","to ponder","to contemplate","to reflect (on)","to meditate (on)"]],["感じる","かんじる","ichidan",["to feel","to sense","to experience"]],["消える","きえる","ichidan",["to go out","to vanish","to disappear"]],["聞く","きく","godan",["to hear"]],["聞こえる","きこえる","ichidan",["to be heard","to be audible"]],["競う","きそう","godan",["to compete","to contend","to vie","to contest"]],["気付く","きづく","godan",["to notice","to recognize","to recognise","to become aware of","to perceive","to realize","to realise"]],["気に入る","きにいる","godan",["to like","to be pleased with","to be delighted with","to take a liking to","to suit one's fancy"]],["決まる","きまる","godan",["to be decided","to be settled"]],["決める","きめる","ichidan",["to decide","to choose","to determine","to make up one's mind","to resolve","to set one's heart on","to settle","to arrange","to set","to appoint","to fix"]],["切る","きる","godan",["to cut","to cut through","to perform (surgery)"]],["着る","きる","ichidan",["to wear (in modern Japanese, from the shoulders down)","to put on"]],["切れる","きれる","ichidan",["to break","to snap","to be cut","to split","to crack"]],["配る","くばる","godan",["to distribute","to hand out","to deliver","to deal out","to serve out"]],["首になる","くびになる","godan",["to be sacked","to be fired","to be dismissed"]],["曇る","くもる","godan",["to get cloudy","to cloud over","to become overcast"]],["来る","くる","special",["to come (spatially or temporally)","to approach","to arrive"]],["苦しむ","くるしむ","godan",["to suffer","to groan","to be worried"]],["消す","けす","godan",["to erase","to delete","to cross out"]],["試みる","こころみる","ichidan",["to try","to attempt","to have a go (at something)"]],["答える","こたえる","ichidan",["to answer","to reply"]],["好む","このむ","godan",["to like","to prefer"]],["転がる","ころがる","godan",["to roll","to tumble"]],["殺す","ころす","godan",["to kill","to slay","to murder","to slaughter"]],["転ぶ","ころぶ","godan",["to fall down","to fall over"]],["壊れる","こわれる","ichidan",["to be broken","to break"]],["下がる","さがる","godan",["to come down","to go down","to fall","to drop","to sink","to get lower"]],["咲く","さく","godan",["to bloom"]],["下げる","さげる","ichidan",["to hang","to suspend","to wear (e.g. decoration)"]],["支える","ささえる","ichidan",["to support","to prop","to sustain","to underlay","to hold up","to defend"]],["指す","さす","godan",["to point"]],["死ぬ","しぬ","godan",["to die","to pass away"]],["締める","しめる","ichidan",["to tie","to fasten","to tighten"]],["調べる","しらべる","ichidan",["to examine","to look up","to investigate","to check up","to sense","to study","to inquire","to search"]],["知る","しる","godan",["to be aware of","to know","to be conscious of","to cognize","to cognise"]],["信じる","しんじる","ichidan",["to believe","to believe in","to place trust in","to confide in","to have faith in"]],["吸う","すう","godan",["to smoke","to breathe in","to inhale"]],["空く","すく","godan",["to become less crowded","to thin out","to get empty"]],["進む","すすむ","godan",["to advance","to go forward"]],["住む","すむ","godan",["to live (of humans)","to reside","to inhabit","to dwell","to abide"]],["為る","する","special",["to become","to get","to grow","to be","to reach","to attain"]],["座る","すわる","godan",["to sit","to squat"]],["注ぐ","そそぐ","godan",["to pour (into)"]],["育つ","そだつ","godan",["to be raised (e.g. child)","to be brought up","to grow (up)"]],["育てる","そだてる","ichidan",["to raise","to rear","to bring up"]],["足す","たす","godan",["to add (numbers)"]],["助かる","たすかる","godan",["to be saved","to be rescued","to survive"]],["助ける","たすける","ichidan",["to save","to rescue"]],["戦う","たたかう","godan",["to make war (on)","to wage war (against)","to go to war (with)","to fight (with)","to do battle (against)"]],["正す","ただす","godan",["to correct","to rectify","to reform","to amend","to redress"]],["立つ","たつ","godan",["to stand","to rise","to stand up"]],["立てる","たてる","ichidan",["to stand up","to put up","to set up","to erect","to raise"]],["楽しむ","たのしむ","godan",["to enjoy (oneself)"]],["食べる","たべる","ichidan",["to eat"]],["試す","ためす","godan",["to attempt","to test","to try out"]],["保つ","たもつ","godan",["to keep","to preserve","to hold","to retain","to maintain","to sustain"]],["足りる","たりる","ichidan",["to be sufficient","to be enough"]],["出す","だす","godan",["to take out","to get out"]],["近づく","ちかづく","godan",["to approach","to draw near","to get close"]],["違う","ちがう","godan",["to differ (from)","to vary"]],["使う","つかう","godan",["to use (a thing, method, etc.)","to make use of","to put to use"]],["疲れる","つかれる","ichidan",["to get tired","to tire"]],["着く","つく","godan",["to arrive at","to reach"]],["作る","つくる","godan",["to make","to produce","to manufacture","to build","to construct"]],["付ける","つける","ichidan",["to attach","to join","to add","to append","to affix","to stick","to glue","to fasten","to sew on","to apply (ointment)"]],["伝える","つたえる","ichidan",["to convey","to report","to transmit","to communicate","to tell","to impart","to propagate","to teach","to bequeath"]],["伝わる","つたわる","godan",["to be handed down","to be introduced","to be transmitted","to be circulated","to go along","to walk along"]],["積もる","つもる","godan",["to pile up","to accumulate"]],["手伝う","てつだう","godan",["to help","to assist","to aid"]],["出会う","であう","godan",["to meet (by chance)","to come across","to run across","to encounter","to happen upon"]],["出かける","でかける","ichidan",["to go out (e.g. on an excursion or outing)","to leave","to depart","to start","to set out"]],["出来上がる","できあがる","godan",["to be completed","to be finished","to be ready (e.g. to serve or eat)"]],["出来る","できる","ichidan",["to be able (in a position) to do","to be up to the task"]],["出る","でる","ichidan",["to leave","to exit","to go out","to come out","to get out"]],["通す","とおす","godan",["to stick through","to force through"]],["通る","とおる","godan",["to go by","to go past","to go along","to travel along","to pass through","to use (a road)","to take (a route)","to go via","to go by way of"]],["整える","ととのえる","ichidan",["to put in order","to arrange","to tidy up","to straighten","to adjust","to fix"]],["止まる","とまる","godan",["to stop (moving)","to come to a stop"]],["止める","とめる","ichidan",["to stop","to turn off"]],["撮る","とる","godan",["to take (a photo)"]],["直す","なおす","godan",["to cure","to heal"]],["直る","なおる","godan",["to be cured","to get well","to be healed"]],["流す","ながす","godan",["to drain","to pour","to spill","to shed (blood, tears)"]],["流れる","ながれる","ichidan",["to stream","to flow (liquid, time, etc.)","to run (ink)"]],["鳴く","なく","godan",["to sing (bird)"]],["亡くなる","なくなる","godan",["to die"]],["投げ付ける","なげつける","ichidan",["to throw at","to throw something at a person","to throw a person down"]],["投げる","なげる","ichidan",["to throw","to hurl","to fling","to toss","to cast"]],["習う","ならう","godan",["to take lessons in","to be taught","to learn (from a teacher)","to study (under a teacher)","to get training in"]],["成る","なる","godan",["to become","to get","to grow","to be","to reach","to attain"]],["似合う","にあう","godan",["to suit","to match","to become","to be like"]],["煮る","にる","ichidan",["to boil","to simmer","to stew","to seethe"]],["寝る","ねる","ichidan",["to lie down"]],["残る","のこる","godan",["to remain","to be left"]],["乗せる","のせる","ichidan",["to place on (something)"]],["望む","のぞむ","godan",["to desire"]],["上る","のぼる","godan",["to ascend","to go up","to climb"]],["飲む","のむ","godan",["to drink","to gulp","to swallow","to take (medicine)"]],["乗る","のる","godan",["to get on (train, plane, bus, ship, etc.)","to get in","to board","to take","to embark"]],["入る","はいる","godan",["to enter","to go into"]],["生える","はえる","ichidan",["to grow","to spring up","to sprout"]],["履く","はく","godan",["to put on (lower-body clothing, e.g. pants, skirt, footwear)","to wear"]],["運ぶ","はこぶ","godan",["to carry","to transport","to move","to convey"]],["走り回る","はしりまわる","godan",["to run around"]],["走る","はしる","godan",["to run"]],["始まる","はじまる","godan",["to begin","to start","to commence"]],["始める","はじめる","ichidan",["to start","to begin","to commence","to initiate","to originate"]],["外れる","はずれる","ichidan",["to be disconnected","to get out of place","to be off","to be out (e.g. of gear)"]],["働く","はたらく","godan",["to work","to labor","to labour"]],["話す","はなす","godan",["to talk","to speak","to converse","to chat"]],["放つ","はなつ","godan",["to fire (gun, arrow, questions, etc.)","to shoot","to hit (e.g. baseball)","to break wind"]],["放れる","はなれる","ichidan",["to get free (from)","to be freed","to be released"]],["払う","はらう","godan",["to pay (e.g. money, bill)"]],["晴れる","はれる","ichidan",["to clear up","to clear away","to be sunny","to stop raining"]],["化かす","ばかす","godan",["to bewitch","to confuse","to enchant","to delude"]],["化ける","ばける","ichidan",["to take the form of (esp. in ref. to a spirit, fox, raccoon dog, etc.)","to assume the shape of","to turn oneself into","to transform oneself into"]],["光る","ひかる","godan",["to shine","to glitter","to be bright"]],["引く","ひく","godan",["to pull","to tug","to lead (e.g. a horse)"]],["拾う","ひろう","godan",["to pick up","to find","to gather"]],["吹く","ふく","godan",["to blow (e.g. wind)","to play a wind instrument"]],["太る","ふとる","godan",["to put on weight","to gain weight","to grow fat","to get stout"]],["降る","ふる","godan",["to fall (of rain, snow, ash, etc.)","to come down"]],["参る","まいる","godan",["to go","to come","to call"]],["曲がる","まがる","godan",["to bend","to curve","to warp","to wind","to twist"]],["負ける","まける","ichidan",["to lose","to be defeated"]],["曲げる","まげる","ichidan",["to bend","to crook","to bow","to curve","to curl"]],["交じる","まじる","godan",["to be mixed","to be blended with","to associate with","to mingle with","to interest","to join"]],["交わる","まじわる","godan",["to cross","to intersect","to join","to meet"]],["交ぜる","まぜる","ichidan",["to mix","to stir","to blend"]],["待たせる","またせる","ichidan",["to keep (a person) waiting"]],["間違える","まちがえる","ichidan",["to make a mistake (in)","to commit an error (e.g. in calculation)"]],["待つ","まつ","godan",["to wait"]],["学ぶ","まなぶ","godan",["to study (in depth)","to learn","to take lessons in"]],["間に合う","まにあう","godan",["to be in time for"]],["迷う","まよう","godan",["to lose one's way"]],["回す","まわす","godan",["to turn","to rotate","to spin","to twist","to gyrate"]],["回る","まわる","godan",["to turn","to revolve"]],["見当たる","みあたる","godan",["to be found"]],["見える","みえる","ichidan",["to be seen","to be in sight"]],["見送る","みおくる","godan",["to see someone off (at a station, an airport, etc.)","to escort (e.g. home)"]],["見返す","みかえす","godan",["to look (stare) back at (somebody)"]],["見返る","みかえる","godan",["to look back"]],["見せる","みせる","ichidan",["to show","to display"]],["見付ける","みつける","ichidan",["to discover","to find (e.g. an error in a book)","to come across","to detect","to spot"]],["見直す","みなおす","godan",["to look at again"]],["見る","みる","ichidan",["to see","to look","to watch","to view","to observe"]],["見分ける","みわける","ichidan",["to distinguish","to recognize","to recognise","to tell apart","to differentiate (both figuratively and visually)"]],["迎える","むかえる","ichidan",["to go out to meet"]],["向く","むく","godan",["to turn toward","to look (up, down, etc.)"]],["向ける","むける","ichidan",["to turn towards","to point"]],["申す","もうす","godan",["to say","to be called"]],["用いる","もちいる","ichidan",["to use","to make use of","to utilize","to utilise"]],["持つ","もつ","godan",["to hold (in one's hand)","to take","to carry"]],["求める","もとめる","ichidan",["to want","to wish for"]],["貰う","もらう","godan",["to receive","to take","to accept"]],["役に立つ","やくにたつ","godan",["to be helpful","to be useful"]],["養う","やしなう","godan",["to support","to maintain","to provide for"]],["休む","やすむ","godan",["to be absent","to take a day off"]],["病む","やむ","godan",["to fall ill"]],["遣る","やる","godan",["to do","to undertake","to perform","to play (a game)","to study"]],["読む","よむ","godan",["to read"]],["喜ぶ","よろこぶ","godan",["to be delighted","to be glad","to be pleased"]],["分かる","わかる","godan",["to understand","to comprehend","to grasp","to see","to get","to follow"]],["別れる","わかれる","ichidan",["to part (usu. of people)","to part from","to part with","to be apart from"]],["分ける","わける","ichidan",["to divide (into)","to split (into)","to part","to separate","to divide up","to classify","to sort out","to divide out"]],["渡る","わたる","godan",["to cross over","to go across"]],["過ぎる","～すぎる","ichidan",["to pass through","to pass by","to go beyond"]]]

U     = "う".freeze
TSU   = "つ".freeze
RU    = "る".freeze
GODAN_GROUP_ONE_MATCH = /[#{[U, TSU, RU].join}]\Z/.freeze

NU    = "ぬ".freeze
BU    = "ぶ".freeze
MU    = "む".freeze
GODAN_GROUP_TWO_MATCH = /[#{[NU, BU, MU].join}]\Z/.freeze

KU    = "く".freeze
GODAN_GROUP_THREE_MATCH = /#{KU}\Z/.freeze
GODAN_GROUP_THREE_EXCEPTIONS = ["いく", "行く"].freeze

GU    = "ぐ".freeze
GODAN_GROUP_FOUR_MATCH = /#{GU}\Z/.freeze

SU    = "す".freeze
GODAN_GROUP_FIVE_MATCH = /#{SU}\Z/.freeze

MASU  = "ます".freeze

TE    = "て".freeze
TTE   = "って".freeze
NDE   = "んで".freeze
ITE   = "いて".freeze
IDE   = "いで".freeze
SHITE = "して".freeze

TA    = "た".freeze
TTA   = "った".freeze
NDA   = "んだ".freeze
ITA   = "いた".freeze
IDA   = "いだ".freeze
SHITA = "した".freeze

U_TO_I =   {
  "う" => "い",
  "く" => "き",
  "ぐ" => "ぎ",
  "す" => "し",
  "ず" => "じ",
  "つ" => "ち",
  "づ" => "ぢ",
  "ぬ" => "に",
  "ふ" => "ひ",
  "ぶ" => "び",
  "ぷ" => "ぴ",
  "む" => "み",
  "る" => "り"
}.freeze
U_MATCH = /[#{U_TO_I.keys.join}]\Z/.freeze


def godan_masu_form(verb)
  verb.sub(U_MATCH, U_TO_I) + MASU
end

def godan_te_form(verb)
  return verb.chop + TTE if GODAN_GROUP_THREE_EXCEPTIONS.include?(verb)

  case verb
  when GODAN_GROUP_ONE_MATCH   then verb.chop + TTE
  when GODAN_GROUP_TWO_MATCH   then verb.chop + NDE
  when GODAN_GROUP_THREE_MATCH then verb.chop + ITE
  when GODAN_GROUP_FOUR_MATCH  then verb.chop + IDE
  when GODAN_GROUP_FIVE_MATCH  then verb.chop + SHITE
  end
end

def godan_ta_form(verb)
  return verb.chop + TTA if GODAN_GROUP_THREE_EXCEPTIONS.include?(verb)

  case verb
  when GODAN_GROUP_ONE_MATCH   then verb.chop + TTA
  when GODAN_GROUP_TWO_MATCH   then verb.chop + NDA
  when GODAN_GROUP_THREE_MATCH then verb.chop + ITA
  when GODAN_GROUP_FOUR_MATCH  then verb.chop + IDA
  when GODAN_GROUP_FIVE_MATCH  then verb.chop + SHITA
  end
end
def ichidan_masu_form(verb)
  verb.delete_suffix(RU) + MASU
end

def ichidan_te_form(verb)
  verb.delete_suffix(RU) + TE
end

def ichidan_ta_form(verb)
  verb.delete_suffix(RU) + TA
end

def special_masu_form(verb)
  verb.delete_suffix(RU).sub(U_MATCH, U_TO_I) + MASU
end

def special_te_form(verb)
  verb.delete_suffix(RU).sub(U_MATCH, U_TO_I) + TE
end

def special_ta_form(verb)
  verb.delete_suffix(RU).sub(U_MATCH, U_TO_I) + TA
end

def masu_form(verb, type)
  send("#{type}_masu_form", verb)
end

def te_form(verb, type)
  send("#{type}_te_form", verb)
end

def ta_form(verb, type)
  send("#{type}_ta_form", verb)
end

header = [
  "#{RU} form",
  "reading",
  "#{MASU} form",
  "#{TE} form",
  "#{TA} form"
]
rows = verbs.shuffle.map do |ru_form, reading, type, translations|
  [
    ru_form,
    reading,
    masu_form(reading, type),
    te_form(reading, type),
    ta_form(reading, type)
  ]
end

html = <<HTML
<html>
<head>
<style>
  table{
    max-width: 2480px;
    width:100%;
  }
  thead {
    text-align: left;
  }
  table td{
    width: auto;
    overflow: hidden;
    word-wrap: break-word;
  }
</style>
</head>
<body>
#{Thamble.table(rows, headers: header)}
</body>
</html>
HTML

File.write("table.html", html)
