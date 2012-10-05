
How to run
====================

まず最初に、 ruby 1.9.3 の環境と、 Bundler があることを確認してください。  
もしそれがなければ、システムにとって適切な方法でそれらをインストールしてください。

最初に一度だけセットアップをする必要があります。

.. code:: sh

  git clone git://github.com/pasberth/Totoslg.git
  cd Totoslg
  git submodule init
  git submodule update

  cd ConsoleWindow
  git submodule init
  git submodule update
  cd TextDisplay/ext/text_display/ext
  ruby extconf.rb
  make
  cd ../../../../..

次に Totoslg ディレクトリまで戻って、依存したモジュールを bundle でインストールしてください。

.. code:: sh

  bundle install --path .bundle

Totoslg はいろいろなデータを ~/.totoslg/totoslg.db に保存しようとします。  
最初に db ファイルを作り、データを書き込む必要があります。

.. code:: sh

  bundle exec rake db:migrate
  bundle exec rake db:update

これまで特にエラーとかなくインストールが成功すれば、たぶん Totoslg は動作するはずです！

Totoslg を走らせるには bundle コマンドを使用します。

.. code:: sh

  bundle exec totoslg

操作方法などは doc/ をご覧くだしあ。

Do you want to create a new map?
=================================

db/update.rb を読んでみて！　Totoslg はマップやキャラクターやらのデータを db/data/**/*.rb に置いています。
これは通常実行されませんが rake db:updare で実行されデータを追加できます。
このファイルをいじれば簡単にマップを作成できます。

どうやって書けばいいかはあとで書くよ！　ちょっと待ってね。
