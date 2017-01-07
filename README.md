## dvipdf.bat --- Ghostscript "dvipdf" translated into Windows batch file

Ghostscript には dvipdf というスクリプトが含まれていますが、これは Unix の shell 向けであり、Windows では動作しません。
dvipdf.bat は、このシェルスクリプトと同じことを行う Windows バッチファイルです。
すなわち、入力した DVI ファイルを dvips + gs (pdfwrite) に通して PDF を出力します。

- dvipdf.bat 一次配布元
    - dvipdf.bat https://github.com/aminophen/dvipdf
- dvipdf.bat 旧配布場所
    - dvipdf.bat https://gist.github.com/aminophen/7d51e2f9e58056ebc4b4

### 動作条件

- Windows のコマンド プロンプトで動作します。
- TeX ディストリビューションに含まれる dvips と、Ghostscript (pdfwrite) が必要です。

### インストールと設定

基本的に Windows のコマンド プロンプトから呼び出すことを想定しています。
dvipdf.bat をパスの通ったディレクトリに置けば，インストールは完了です。

TeX Live や W32TeX での利用を想定し、Ghostscript の実行ファイル名に rungs.exe を仮定しています。
もし standalone の Ghostscript を直接呼び出したい場合は

    set GS_EXECUTABLE=rungs.exe

という行を適宜書きかえてください。

### 使い方

コマンドラインから

    $ dvipdf [options...] input.dvi [output.pdf]

という形式で実行します。
オプションの扱いは Ghostscript の dvipdf シェルスクリプトと同じです。
すなわち、オプションのうち `-R` で始まるものは dvips に渡り、それ以外はすべて rungs に渡ります。

### オリジナルとの違い

オリジナルと意図的に違う挙動をさせているのが、dvips と gs に渡すデフォルトオプションです。
オリジナルを完全に再現するには

    %DVIPS% -q -Ppdf %DVIPSOPTIONS% -f "%infile%" | %GS_EXECUTABLE% %OPTIONS% -P- -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sstdout=%%stderr -sOutputFile="%outfile%" %OPTIONS% -c .setpdfwrite -

とする必要がありますが、バッチファイル版では

- `-q` オプション
    - 静粛モードではログが出ないので、デバッグしづらい
- `-sstdout=%%stderr` オプション
    - gs の標準出力が標準エラー出力にリダイレクトされ、dvips のログと混ざって見づらい

という理由から、これらのオプションを除去しました。

### ライセンス

AGPL Ghostscript の dvipdf を翻訳したものであるため、GNU Affero General Public License を適用します。

--------------------
Hironobu YAMASHITA (aka. "Acetaminophen" or "@aminophen")
http://acetaminophen.hatenablog.com/
