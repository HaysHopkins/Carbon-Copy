require 'Matrix'

def difficulty

  puts 'To get more info about the game enter \'4\' (highly recommended for first time users) or enter \'1\' to exit (any other input to continue):'
  info = gets.to_i
  puts ' '

  if info == 4
    getInfo
  elsif info == 1
    sayGoodbye
    exit
  end

  puts 'Select your difficulty: \'E\'asy, \'M\'edium, or \'H\'ard:'
  difficulty_setting = gets.upcase
  difficulty_setting = getIntValue(difficulty_setting)
  puts ''

  puts "Select your level 1-5 (each additional level adds a new symbol):"
  level = gets.to_i
  puts ''

  puts "Select your time to memorize:"
  time_to_memorize = gets.to_i
  puts ''

  createGame(difficulty_setting, level, time_to_memorize)

end


def getIntValue(difficulty_setting)

  if difficulty_setting.chomp.eql? 'H'
    difficulty_setting = 5
  elsif difficulty_setting.chomp.eql? 'M'
    difficulty_setting = 4
  else
    difficulty_setting = 3
  end

end


def createGame(difficulty_setting, level, time_to_memorize)

  if ![1, 2, 3, 4, 5].include?(level) || ![3, 4, 5].include?(difficulty_setting)
    puts 'Whoops! Let\'s redo that! (The level must be 1-5)'
    puts ''
    difficulty
  else
    game_board = createMatrix(level*2, difficulty_setting)
  end

  if !(1..30).to_a.include?(time_to_memorize)
    puts 'Whoops! Let\'s redo that! (Max time should be no more than 30 and no less than 1)'
    puts ''
    difficulty
  elsif time_to_memorize === 0
    exit
  else
    playGame(game_board, time_to_memorize, difficulty_setting, level)
  end

end


def createMatrix(number_of_symbols, difficulty_setting)

  symbols = [' ', '#', ' ', '+', ' ', '*', ' ', '@', ' ', '&']
  game_board =
      Matrix.build(difficulty_setting) {|row, col| symbols[rand(number_of_symbols)]}

end


def playGame(game_board, time_to_memorize, difficulty_setting, level)

  start = Time.now.to_i

  printGameBoard(game_board, difficulty_setting)

  #Time the display
  until time_to_memorize < Time.now.to_i - start
  end
  #Move the game board off screen
  puts "\n" * 65

  user_answer = getUserAnswer(difficulty_setting)
  puts user_answer[7]
  getUserScore(game_board, user_answer, difficulty_setting, level, time_to_memorize)

end


def printGameBoard(game_board, difficulty_setting)

  puts ' ___________________________'
  puts '    Memorize this matrix:'
  puts ' '
  for i in 0...difficulty_setting
    for j in 0...difficulty_setting
      print ' | '
      print game_board.[](i, j)
    end
    print ' | '
    puts ''
  end
  puts ' ___________________________'

end


def getUserAnswer(difficulty_setting)

  puts '-Enter your answer, including only those symbols from the original board.'
  puts '-Only 3, 4, or 5 symbols (or spaces) per line, depending on if you chose \'E\', \'M\', or \'H\' (don\'t include \'|\').'
  puts '-Any input beyond the xth space per line will be disregarded!'
  puts ''
  puts 'Create your Carbon Copy:'
  puts ''

  input = Array.new()
  for i in 0...difficulty_setting
    chars = gets.split(//)
    input[i] = chars
  end

  input

end


def getUserScore(game_board, user_answer, difficulty_setting, level, time_to_memorize)

  score = 0
  for i in 0...difficulty_setting

    game_board_row = game_board.row(i)
    user_answer_row = user_answer[i]

    #Handling no input
    if user_answer_row == nil
      score = score - (5 * difficulty_setting)
      next
    end

    for j in 0...difficulty_setting
      key = game_board_row[j].chomp

      #Handling undesired input

      if user_answer_row == nil
        next
      elsif user_answer_row[j] == nil
        score = score - ((difficulty_setting - j - 1) * 5)
        next
      else
        answer = user_answer_row[j].chomp

        if key.eql? answer
          score += 10
        else
          score -= 5
        end
      end

    end
  end

  puts ''
  if score > 0
    puts 'Your score is: '
    puts (score * difficulty_setting * level) / time_to_memorize
    puts 'Well done! Keep up the practice to try to get a higher score! Remember to keep track!'
  else
    puts 'You\'re in the negative! Try an easier setting and improve slowly.'
  end
  puts ''

  start = Time.now
  while 3 > Time.now - start
  end

end


def playAgain

  puts 'Would you like to play again? (\'1\' to exit or any other input to continue)'
  input = gets.to_i

  if input == 1
    sayGoodbye
    exit
  end

end


def getInfo
  puts '__________________________________________________________________________________________________________________________________'
  puts 'Here\'s the \'4\'11 on Carbon-Copy!'
  puts ''
  puts 'This is a game designed to test your memory. So keep track of your high scores. It would be counterproductive for us to do that for you!'
  puts ''
  puts ''
  puts 'Settings:'
  puts ''
  puts '-After you have followed the instructions to choose your desired settings, you will be presented with a matrix.'
  puts '-This matrix will be sized based on your difficulty level (E = 3x3; M = 4x4; H = 5x5) and will contain the number of symbols determiend by your level.'
  puts '-Each level adds a symbol with a space being the default included.'
  puts '-After you are presented with the matrix and your requested time has elapsed (between 1 and 30 seconds), you will be tasked with replicating it.'
  puts '  ...Or...creating a Carbon Copy!'
  puts ''
  puts 'Inputing your answer:'
  puts ''
  puts '-When entering your answer, be sure not to replicate the structure, but only the spaces and symbols.'
  puts '-Any extra input (beyond 3, 4, or 5, depending on difficulty) will not be considered and may lower your scored'
  puts ''
  puts 'How it\'s scored:'
  puts ''
  puts '-Your score will be based on whether or not you have a symbol or space in the correc spot (10pts each).
-False answers will be penalized by 5 points.
-This total will then be multiplied by the difficulty (3, 4, or 5) and the level (1-5).
-Lastly, your final score will be divided by the amount of time you took to memorize the matrix.'
  puts ''
  puts 'It starts easy but, trust me, it gets harder to make a carbon copy!'
  puts 'Good luck!'
  puts '__________________________________________________________________________________________________________________________________'
  puts ''
  puts ''

end


def sayGoodbye
  puts "

                                                                                                       :; ,:.
                                                                             ;;;,                      :: ,:.
                                                                            ;::::.                     :; ,:.
                                                                           ;;;;;;;                     ;; ,;.
                                                                           ;;;;;;;                     ;; ,;.
                                                                          ,;;`  :;                     ;; ,;.
                                                                          ;';    .   ;;;    `;;:    ;;`'; ,'.;;, .;`  :;  ,;;`
                                                                          ''`       ;''';   '''',  :'';'' ,';''' :':  ''  ''''
                                                                          ''       `'''''  :'''''  '''''' ,'''''..';  '' ;''''.
                                                                          +'  ```  :+;,'+, '+;:++  ++;'+' ,++;'+; +'  +' '+`,+;
                                                                          ''  '''; ''` :'; ''  ;'`.'; :'' ,'' ,'' '' `'; ''  ''
                                                                          '' `'''; ''  `'; ';  :',,':  '' ,',  '' '' ,', ';  ''
                                                                          ';  ;;'; ''   ';`';  ,'::'.  '; ,'.  '; ;'.:'``';;;''
                                                                          ;;   `;; ;;   ;;`;;  ,;::;.  ;; ,;.  ;; ,;:;; .;;;;;;
                                                                          ;;   `;; ;;   ;;`;;  ,;::;.  ;; ,;.  ;; `;;;; .;;;;;;
                                                                          ::.  `:: ::   ::`::  ::,::,  :: ,:.  ::  :::: `::
                                                                          :::  `:: ::  .:: ::  ::.,:: `:: ,:: `::  ::::  ::
                                                                          ,,,;`:,: :,: :,, ,,` :, `,: :,: ,,,`;,:  :,,:  ,:   :
                                                                           ,,,,,,: :,,:,,  :,,:,,  ,,,,,, ,,,,,,,  :,,.  ,,:;,:
                                                                           :,,,,,:  ,,,,:  ,,,,,:  ,,,,,, ,,:,,,   .,,   :,,,,:
                                                                            ;...:`  ;..,`   :..:   ...::, ,.`..:    ..    :..,.
                                                                             `,.     .,      ,,     .,       `,     ..     ,,
                                                                                                                   `.,               "
end


puts "
  ,:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                           :,  `:`  `:       `;:                                                                                                          .:
  ,:                                                          `;;  ;';  ;'`      `':                                  ;;                                                                      .:
  ,:                                                           ''  ;';  ;'       `':                                  ';                                                                      .:
  ,:                                                           ;+` '++  ';  :;;. `+:  ;;;  .;;;  ,;`;;`,;;   :;;,    ;';;` ,;;;   ;                                                           .:
  ,:                                                           :'.`';'.`': :';''``': ;''':`''''; :';'';''': :';''`   ''''.,''''; ,':                                                          .:
  ,:                                                           ,;:.;:':.;, ;; .;:`;: ;;`:::': ;;`:;;.;';,;; ;; .;:   ,;;, ;;,`;; ,;:                                                          .:
  ,:                                                            ;;:;`;;:;` ;;;;;;`;:.;;   ;;  :;,:;, ;;  ;; ;;;;;;    ;;  ;;  ;;` .                                                           .:
  ,:                                                            ::;: ::;:  :::::;`::,::   ::  ,::::, ;:  :: :::::;    ::  ::  ;:`                                                             .:
  ,:                                                            :::: ::::  ::    `,:.,;   :,  ;,,:,, :,  :: ::        ::  ::  :,`                                                             .:
  ,:                                                            :,,: :,,:  :,,`:.`,: ,,:;::,;.:,`:,, :,  ,: :,,`:.    ,,:`:,:,,: ,,:                                                          .:
  ,:                                                            ,.., ,..,  :....,`.: ;...:`,...: :., :.  .: :....,    :...,....: ,.:                                                          .:
  ,:                                                             ;;   ;;    ,;;:  ;,  :;:  `;;:  .;` :;  ;:  ,;;:      ;;  .;;,   ;`                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:                                                       .                 ,:;                               `.                                                                             .:
  ,:                                                    `;:::;               ,:;                             ,;::::                                                                           .:
  ,:                                                    ;;;;;;,              ,;;                            ,;;;;;;                                                                           .:
  ,:                                                   ;;;;.:;,              ,;;                            ;;;:.;;                                                                           .:
  ,:                                                   ;';   `  ,;;;;  `;::;,,';:;;,   `;;;;   ;; ;;;      .'',   ,   ;;;;   ;; ;;;  ;;.  ,;:                                                 .:
  ,:                                                  `'',     ,''''': .';'':,';''''`  ;'''';  ;';''';     :''       ;'''';  ;';'''; ;';  ;';                                                 .:
  ,:                                                  .+'      ,';,;+; .++';:,++;;'+: :+':;++, ;++;;+'     ;+;      ;+':;++, '++;;+' :+;  '+.                                                 .:
  ,:                                                  ,''          .'' .'':  ,''` ;'; ;':  ;'; ;'; `''`    ;';      '':  ;'; ;';  '',`''``''                                                  .:
  ,:                                                  ,';       `;;;'; .';   ,';  ,'; ;'`  :'; ;',  ;'`    ;';      ''`  ;'; ;',  ;': ;',,';                                                  .:
  ,:                                                  .;;`     `;;;;;; .;;   ,;;  .;; ;;`  :;; ;;,  ;;`    :;;     `;;`  ;;; ;;,  ;;: :;;;;;                                                  .:
  ,:                                                   :::     ;:;`.:: .::   ,:;  ,:: ::.  ::; ::,  ::`    :::`     ::`  ;:; ::,  ::: ,::::`                                                  .:
  ,:                                                   :::,  ;:::, .:: .::   ,::. ::; :::  ::: ::,  ::`    `::;  .; :::  ::: ::; .::.  ::::                                                   .:
  ,:                                                   ,,,,:,,:;,:;:,: .,,   ,,,,:,,: :,,;:,,` :,,  ,,`     ;,,,:,, ;,,;:,,` :,,::,:   :,,;                                                   .:
  ,:                                                    ;....:`.,..:,, ..,   ,.;,..:   :....:  :.,  ..`      :....:  :...,:  :.;...:   ,..:                                                   .:
  ,:                                                     .;;:   .;; ::  ::   `:`.;;     :;;.   ,:   ::        ,;;,    :;;`   ,.,:;,    `..`                                                   .:
  ,:                                                                                                                         ,.,       ,.,                                                    .:
  ,:                                                                                                                         ,.,       :.;                                                    .:
  ,:                                                                                                                         :.,       ,,,                                                    .:
  ,:                                                                                                                                                                                          .:
  ,:                                                                                                                                                                                          .:
  ,:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  puts ''
  puts "-The objective of the game is to use your keyboard to replicate the symbols that are presented to you.  \n-Replicating both the type of symbol and its location matters."
  puts ''

while true
  difficulty
  playAgain
end


