ConsoleWindow で、今よくわからない理由で落ちるバグがあることがわかってる

そのためのパッチファイル avoidbug.patch

これはバグをとりあえず回避できるけど、なにが原因かよくわからない(あんまり発生しない)ので ConsoleWindow のリポジトリには置きたくないが
Totoslgとしては回避できないと困るのであててる


.. code::

  patch ConsoleWindow/lib/console_window/container.rb < memo/avoidbug.patch
