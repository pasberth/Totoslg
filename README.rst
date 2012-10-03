
How to run
====================

まず最初に、 ruby 1.9.3 の環境と、 Bundler があることを確認してください。  
もしそれがなければ、システムにとって適切な方法でそれらをインストールしてください。

最初に一度だけセットアップをする必要があります。

.. code::

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

次に Totoslg ディレクトリまで戻って、依存したモジュールを bundle でインストールしてください。

.. code::

  bundle install --path .bundle


これまで特にエラーとかなくインストールが成功すれば、たぶん Totoslg は動作するはずです！

Totoslg を走らせるには bundle コマンドを使用します。

.. code::

  bundle exec totoslg

操作方法などは doc/ をご覧くだしあ。
