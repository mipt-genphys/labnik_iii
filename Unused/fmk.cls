
% custom class building: https://www.sharelatex.com/learn/Writing_your_own_class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fmk}

\LoadClass{book}

% define condition for compact page layout
\newif\ifcompact
\compactfalse

% declare option for compact page layout
\DeclareOption{compact}{
	\compacttrue
	\PassOptionToClass{a5paper}{book}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions\relax

%---------------------------------------------------------------------------------------------------
%   Стилевой пакет для FMK и вообще           ------------------------------------------------------
%   (C) Кирилл Чувилин aka KiRiK 16.04.2009   ------------------------------------------------------
%---------------------------------------------------------------------------------------------------

\long\def\block#1#2{#2}% для обозначения логического блока

%---------------------------------------------------------------------------------------------------
\block{Подключаем другие пакеты}{%------------------------------------------------------------------
%  \block{Поддержка языков}{%
%
%  }
  \block{Математика}{%
    \RequirePackage{amsmath}  % дополнительные возможности математики AMS
    \RequirePackage{amssymb}  % дополнительные символы AMS
    \RequirePackage{mathrsfs} % для значка ЭДС
  }
  \block{Графика}{%
    \RequirePackage{graphicx} % вставка графики
    \RequirePackage{wrapfig}  % обтекание объектов
    \RequirePackage{psfrag}   % вставка надписей
    \RequirePackage{color}    % цветной текст
  }
  \block{Форматирование}{%
    \RequirePackage{soul}      % разрядка, подчеркивание и т.д.
    \RequirePackage{soulutf8}
    \RequirePackage{array}     % дополнительные стили для таблиц
    \RequirePackage{booktabs}
    \RequirePackage{longtable} % таблицы на несколько страниц
  }
  \block{Программирование}{%
    \RequirePackage{ifthen} % ветвление
    \RequirePackage{calc}   % вычисления
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Системное}{%---------------------------------------------------------------------------------

  \def\@package@name{fmk_general}% имя пакета
  \def\@package@message#1{% сообщение
    \message{\@package@name: #1}% оставляем сообщение
  }

  \def\swap#1#2{% глобально меняет местами 2 макроса
    \begingroup % начинаем группу
      \let\tmp=#1% запоминаем первый макрос
      \global\let#1=#2% записываем в первый макрос второй
      \global\let#2=\tmp % записываем во второй макрос запомненное значение
    \endgroup % заканчиваем группу
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Параметры страницы}{%------------------------------------------------------------------------

	\ifcompact
		\hoffset=-25pt     % горизонтальный сдвиг страницы
		\voffset=-70pt      % вертикальный сдвиг страницы
	\else
		% сдвиги для печати dvi --------------------------------------------------------------------------
		\hoffset=-125pt     % горизонтальный сдвиг страницы
		\voffset=-70pt      % вертикальный сдвиг страницы
		
		% сдвиги для печати ps ---------------------------------------------------------------------------
		%\hoffset=-4pt       % горизонтальный сдвиг страницы
		%\voffset=-225pt     % вертикальный сдвиг страницы
		
		% расстояния -------------------------------------------------------------------------------------
		\oddsidemargin=89pt % отступ со внутренней стороны
		\topmargin=28pt     % отступ от верха страницы до верхнего колонтитула
		%  \headheight=14pt    % высота верхнего колонтитула
		%  \headsep=6pt        % отступ от верхнего колонтитула до тела документа
		%  \textheight=512pt   % высота тела документа
		%  \textwidth=322pt    % ширина тела документа
		\textwidth=135mm
		\headheight=6mm
		\headsep=2mm
		\textheight=195mm
	\fi
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Оформление текста}{%-------------------------------------------------------------------------

  \parskip=0pt                          % расстояние между абзацами
  \renewcommand{\baselinestretch}{0.95} % интерлиньяж
  \rmfamily\upshape\mdseries            % тип шрифта
  \tolerance=1000                       % балее мягкие пробелы
  \frenchspacing                        % расстояния а-ля французские

  \block{Локализация}{%-----------------------------------------------------------------------------
    \newtoks{\@page@name}% слово "стр."
    \newtoks{\@contents@name}% слово "оглавление"
    \newtoks{\@table@name}% слово "таблица"
    \newtoks{\@table@shortname}% укороченное слово "таблица"
    \newtoks{\@figure@name}% слово "рисунок"
    \newtoks{\@figure@shortname}% укороченное слово "рисунок"
    \newtoks{\@booklist@name}% слова "Список литературы"
    \newtoks{\@hint@name}% слово "подсказка"
  }
  \block{Шрифты}{%----------------------------------------------------------------------------------
    \def\@main@bodyfont{\rmfamily\upshape\mdseries\fontsize{10pt}{11.5pt}\selectfont}% основной шрифт текста
    \def\@head@font{\rmfamily\upshape\mdseries\fontsize{7pt}{7pt}\selectfont}% колонтитулы
    \def\@pagenumber@font{\rmfamily\upshape\mdseries\fontsize{9pt}{9pt}\selectfont}% номер страницы
    \def\@footnote@font{\rmfamily\upshape\mdseries\fontsize{8pt}{8.7pt}\selectfont}% содержание сноски
    \def\@contents@titlefont{\sffamily\upshape\bfseries\fontsize{12pt}{14pt}\selectfont}% заголовок оглавления
    \def\@contents@bodyfont{\rmfamily\upshape\mdseries\fontsize{9pt}{8.5pt}\selectfont}% содержание оглавления
    \def\@@part@titlefont{\sffamily\upshape\bfseries\fontsize{14pt}{17pt}\selectfont}% заголовок части
    \def\@@part@namefont{\sffamily\upshape\bfseries\fontsize{14pt}{17pt}\selectfont}% название части
    \def\@@subpart@titlefont{\sffamily\upshape\bfseries\fontsize{11pt}{12.5pt}\selectfont}% заголовок подчасти
    \def\@@chapter@titlefont{\sffamily\upshape\mdseries\fontsize{10pt}{11.5pt}\selectfont}% заголовок главы
    \def\@@chapter@namefont{\sffamily\upshape\bfseries\fontsize{12pt}{14pt}\selectfont}% название главы
    \def\@@theorem@titlefont{\@main@bodyfont\sffamily\upshape\bfseries}% заголовок теоремы
    \def\@@theorem@namefont{\@main@bodyfont\sffamily\upshape\bfseries}% название теоремы
    \let\@@theorem@conditionfont=\@main@bodyfont % условие теоремы
    \def\@@theorem@hinttitlefont{\@@theorem@conditionfont\itshape}% заголовок подсказки к теореме теоремы
    \let\@@theorem@hintfont=\@@theorem@conditionfont % подсказка к теореме
    \def\@@paragraph@titlefont{\sffamily\upshape\bfseries\fontsize{11pt}{12.5pt}\selectfont}% заголовок параграфа
    \let\@@paragraph@namefont=\@@paragraph@titlefont % название параграфа
    \def\@@section@titlefont{\@main@bodyfont\bfseries}% заголовок раздела
    \def\@@section@namefont{\@main@bodyfont\bfseries}% название раздела
    \def\@table@titlefont{\rmfamily\upshape\mdseries\fontsize{9pt}{9.7pt}\selectfont}% заголовок таблицы
    \def\@table@namefont{\rmfamily\upshape\mdseries\fontsize{9pt}{9.7pt}\selectfont}% название таблицы
    \def\@table@bodyfont{\rmfamily\upshape\mdseries\fontsize{8.5pt}{9.3pt}\selectfont}% шрифт для содержания таблиц
    \def\@figure@titlefont{\rmfamily\upshape\bfseries\fontsize{8.5pt}{9.3pt}\selectfont}% заголовок рисунка
    \def\@figure@namefont{\rmfamily\upshape\mdseries\fontsize{8.5pt}{9.3pt}\selectfont}% название рисунка
  }
  \block{Отбивки}{%---------------------------------------------------------------------------------
    \block{Новые длины}{%---------------------------------------------------------------------------
      \newlength{\@head@spaceToLine}% вертикальный отступ перед линейкой в колонтитулах
      \newlength{\@footnote@spaceTop}% вертикальный отступ перед линейкой сносок
      \newlength{\@footnote@spaceBot}% вертикальный отступ после линейки сносок
      \newlength{\@@part@contents@spaceTop}% верхний отступ для части в оглавлении
      \newlength{\@@part@contents@spaceBot}% нижний отступ для части в оглавлении
      \newlength{\@@part@spaceTop}% верхний отступ перед заголовком части
      \newlength{\@@part@spaceMid}% расстрояние от заголовка до названия части
      \newlength{\@@subpart@contents@spaceTop}% верхний отступ для подчасти в оглавлении
      \newlength{\@@subpart@contents@spaceBot}% нижний отступ для подчасти в оглавлении
      \newlength{\@@subpart@spaceTop}% верхний отступ перед заголовком подчасти
      \newlength{\@@subpart@spaceBox}% высота бокса с заголовком подчасти
      \newlength{\@@chapter@contents@spaceTop}% верхний отступ для главы в оглавлении
      \newlength{\@@chapter@contents@spaceMid}% расстояние от заголовка до названия главы в оглавлении
      \newlength{\@@chapter@contents@spaceBot}% нижний отступ для главы в оглавлении
      \newlength{\@@chapter@spaceTop}% верхний отступ перед заголовком главы
      \newlength{\@@chapter@spaceBox}% высота бокса с заголовком главы
      \newlength{\@@chapter@spaceMid}% расстрояние от линейки до названия главы
      \newlength{\@@chapter@spaceBot}% нижний отступ от названия главы
      \newlength{\@@theorem@spaceTop}% отступ перед теоремой
      \newlength{\@@theorem@spaceBot}% отступ после теоремы
      \newlength{\@@paragraph@contents@spaceTop}% верхний отступ для параграфа в оглавлении
      \newlength{\@@paragraph@contents@spaceBot}% нижний отступ для параграфа в оглавлении
      \newlength{\@@paragraph@spaceTop}% отступ перед заголовком параграфа
      \newlength{\@@paragraph@spaceBot}% отступ после заголовка параграфа
      \newlength{\@@section@spaceTop}% отступ перед заголовком раздела
      \newlength{\@table@spaceTop}% отступ перед таблицей
      \newlength{\@table@spaceMid}% расстояние между названием и таблицей
      \newlength{\@table@spaceBot}% отступ после таблицы
      \newlength{\@figure@spaceTop}% отступ перед картинкой
      \newlength{\@figure@spaceMid}% расстояние между названием и картинкой
      \newlength{\@figure@spaceBot}% отступ после картинки
      \newlength{\@figure@float@spaceTop}% отступ перед плавающей картинкой
      \newlength{\@figure@float@spaceBot}% отступ после плавающей картинки
    }
    \block{Присваиваем значения}{%------------------------------------------------------------------
      \@head@spaceToLine=5pt% вертикальный отступ перед линейкой в колонтитулах
      \@footnote@spaceTop=25pt% вертикальный отступ перед линейкой сносок
      \@footnote@spaceBot=11.5pt% вертикальный отступ после линейки сносок
      \@@subpart@contents@spaceTop=15pt% верхний отступ для подчасти в оглавлении
      \@@subpart@contents@spaceBot=10pt% нижний отступ для подчасти в оглавлении
      \@@part@contents@spaceTop=5pt% верхний отступ для части в оглавлении
      \@@part@contents@spaceBot=0pt% нижний отступ для части в оглавлении
      \@@part@spaceTop=175pt% верхний отступ перед заголовком главы
      \@@part@spaceMid=10pt% расстояние от линейки до названия главы
      \@@subpart@spaceTop=10pt% верхний отступ перед заголовком подчасти
      \@@subpart@spaceBox=30pt% высота бокса с заголовком подчасти
      \@@chapter@contents@spaceTop=6pt% верхний отступ для главы в оглавлении
      \@@chapter@contents@spaceMid=4pt% расстояние от заголовка главы до названия в оглавлении
      \@@chapter@contents@spaceBot=4pt% нижний отступ для главы в оглавлении
      \@@chapter@spaceTop=4pt% верхний отступ перед заголовком главы
      \@@chapter@spaceBox=20pt% высота бокса с заголовком главы
      \@@chapter@spaceMid=6pt% расстояние от линейки до названия главы
      \@@chapter@spaceBot=31pt% нижний отступ от названия главы
      \@@theorem@spaceTop=15pt% отступ перед теоремой
      \@@theorem@spaceBot=15pt% отступ после теоремы
      \@@paragraph@contents@spaceTop=0pt% верхний отступ для параграфа в оглавлении
      \@@paragraph@contents@spaceBot=0pt% нижний отступ для параграфа в оглавлении
      \@@paragraph@spaceTop=25pt% отступ перед заголовком параграфа
      \@@paragraph@spaceBot=8pt% отступ после заголовка параграфа
      \@@section@spaceTop=8pt% отступ перед заголовком раздела
      \@table@spaceTop=15pt% отступ перед таблицей
      \@table@spaceMid=-10pt% расстояние между названием и таблицей
      \@table@spaceBot=-10pt% отступ после таблицы
      \@figure@spaceTop=10pt% отступ перед картинкой
      \@figure@spaceMid=8pt% расстояние между названием и картинкой
      \@figure@spaceBot=10pt% отступ после картинки
      \@figure@float@spaceTop=6pt% отступ перед плавающей картинкой
      \@figure@float@spaceBot=0pt% отступ после плавающей картинки
    }
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Локализация}{%-------------------------------------------------------------------------------

  \frenchspacing            % запрещаем добавление пробела после знаков препинания
  \righthyphenmin=2         % разрешаем перенос 2 последних букв
  \clubpenalty=10000        % нет разрыва после первой строки абзаца
  \widowpenalty=10000       % нет разрыва перед последней строкой абзаца
  \setcounter{topnumber}{0} % максимальное количество картинок вверху страницы

  \block{Перевод}{%---------------------------------------------------------------------------------
    \@page@name={Стр.}% слово "стр."
    \@contents@name={Оглавление}% слово "оглавление"
    \@table@name={Таблица}% слово "таблица"
    \@table@shortname={Табл.}% укороченное слово "таблица"
    \@figure@name={Рис.}% слово "рисунок"
    \@figure@shortname={Рис.}% укороченное слово "рисунок"
    \@booklist@name={Список литературы}% слова "Список литературы"
    \@hint@name={Подсказка}% слово "подсказка"
  }
  \block{Единицы измерения}{%---------------------------------------------------------------------
    \def\Angstrem{\mfont{\fontfamily{ptm}\selectfont\AA}} % Ангстрем
    \def\nm{\mfont{нм}}                                   % наноМетр
    \def\mkm{\mfont{мкм}}                                 % микроМетр
    \def\mm{\mfont{мм}}                                   % миллиМетр
    \def\cm{\mfont{см}}                                   % сантиМетр
    \def\dm{\mfont{дм}}                                   % дециМетр
    \def\m{\mfont{м}}                                     % метр
    \def\km{\mfont{км}}                                   % килоМетр
    \def\li{\mfont{л}}                                    % литр
    \def\mg{\mfont{мг}}                                   % миллиГрамм
    \def\g{\mfont{г}}                                     % грамм
    \def\kg{\mfont{кг}}                                   % килоГрамм
    \def\tonn{\mfont{т}}                                  % тонна
    \def\mks{\mfont{мкс}}                                 % микросекунда
    \def\ms{\mfont{мс}}                                   % милисекунда
    \def\s{\mfont{с}}                                     % секунда
    \def\mi{\mfont{мин}}                                  % минута
    \def\cha{\mfont{ч}}                                   % час
    \def\tfh{\mfont{cут}}                                 % сутки
    \def\Hz{\mfont{Гц}}                                   % Герц
    \def\kHz{\mfont{кГц}}                                 % килоГерц
    \def\MHz{\mfont{МГц}}                                 % мегаГерц
    \def\rad{\mfont{рад}}                                 % радиан
    \def\din{\mfont{дин}}                                 % дино
    \def\N{\mfont{Н}}                                     % Ньютон
    \def\kN{\mfont{кН}}                                   % килоНьютон
    \def\Dj{\mfont{Дж}}                                   % Джоуль
    \def\kDj{\mfont{кДж}}                                 % килоДжоуль
    \def\eV{\mfont{эВ}}                                   % электронВольт
    \def\keV{\mfont{кэВ}}                                 % килоЭлектронВольт
    \def\MeV{\mfont{МэВ}}                                 % мегаЭлектронВольт
    \def\GeV{\mfont{ГэВ}}                                 % гигаЭлектронВольт
    \def\Vt{\mfont{Вт}}                                   % Ватт
    \def\kVt{\mfont{кВт}}                                 % килоВатт
    \def\degree{^\circ}                                   % градус
    \def\celsii{\,^\circ\mfont{C}}                        % градус Цельсия
    \def\kelvin{\mfont{K}}                                % градус кельвина
    \def\mol{\mfont{моль}}                                % моль
    \def\kmol{\mfont{кмоль}}                              % киломоль
    \def\mmrtst{\mfont{мм\,рт.\,ст.}}                     % миллиметр ртутного столба
    \def\mPa{\mfont{мПа}}                                 % миллиПаскаль
    \def\Pa{\mfont{Па}}                                   % Паскаль
    \def\kPa{\mfont{кПа}}                                 % килоПаскаль
    \def\MPa{\mfont{МПа}}                                 % мегаПаскаль
    \def\atm{\mfont{атм}}                                 % атмосфера
    \def\Kl{\mfont{Кл}}                                   % Кулон
    \def\mkA{\mfont{мкА}}                                 % микроАмпер
    \def\mA{\mfont{мА}}                                   % милиАмпер
    \def\A{\mfont{А}}                                     % ампер
    \def\Om{\mfont{Ом}}                                   % Ом
    \def\kOm{\mfont{кОм}}                                 % килоОм
    \def\mkV{\mfont{мкВ}}                                 % микроВольт
    \def\mV{\mfont{мВ}}                                   % милиВольт
    \def\V{\mfont{В}}                                     % Вольт
    \def\mGn{\mfont{мГн}}                                 % мллиГенри
    \def\Gn{\mfont{Гн}}                                   % Генри
    \def\mkF{\mfont{мкФ}}                                 % микроФарат
    \def\F{\mfont{Ф}}                                     % Фарат
    \def\Tl{\mfont{Тл}}                                   % Тесла
    \def\dptr{\mfont{дптр}}                               % диоптрий
    \def\bit{\mfont{бит}}                                 % бит
    \def\dB{\mfont{дБ}}                                   % дециБелл
  }
  \block{Разное}{%--------------------------------------------------------------------------------
    \def\te{\mbox{т.\,е.}\relax}% т.е.
    \def\Te{\mbox{Т.\,е.}\relax}% Т.е.
    \def\tk{\mbox{т.\,к.}\relax}% т.к.
    \def\Tk{\mbox{Т.\,к.}\relax}% Т.к.
    \def\td{\mbox{т.\,д.}\relax}% т.д.
    \def\Td{\mbox{Т.\,д.}\relax}% Т.д.
    \def\tp{\mbox{т.\,п.}\relax}% т.п.
    \def\Tp{\mbox{Т.\,п.}\relax}% Т.п.
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Колонтитулы}{%-------------------------------------------------------------------------------

  \newcommand{\@oddheadtext}{% текст, который выводится в нечетном верхнем колонтитуле
    \rightmark % правая пометка
  }
  \newcommand{\@evenheadtext}{% текст, который выводится в четном верхнем колонтитуле
    \leftmark % левая пометка
  }

  \renewcommand{\@oddhead}{% нечетный верхний колонтитул
    \raisebox{0pt}[\headheight][0pt]% задаем высоту блока равную \headheight и нулевую глубину
    {\vbox{% начало блока
      \hbox to \textwidth{% блок с текстом
        {\@head@font\@oddheadtext}{\@pagenumber@font\thepage}% выводим текст
      }% конец блока с текстом
      \par\vspace{\@head@spaceToLine}% вертикальный отступ перед линейкой
      \hrule height .4pt% горизонтальная линейка
    }}% конец блока
  }
  \renewcommand{\@evenhead}{% четный верхний колонтитул
    \raisebox{0pt}[\headheight][0pt]% задаем высоту блока равную \headheight и нулевую глубину
    {\vbox{% начало блока
      \hbox to \textwidth{% блок с текстом
        {\@pagenumber@font\thepage}{\@head@font\@evenheadtext}% выводим текст
      }% конец блока с текстом
      \par\vspace{\@head@spaceToLine}% вертикальный отступ перед линейкой
      \hrule height .5pt% горизонтальная линейка
    }}% конец блока
  }

  \renewcommand{\@oddfoot}{}% нет нечетного нижнего колонтитула
  \renewcommand{\@evenfoot}{}% нет четного нижнего колонтитула
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
% Пока не получается свернуть в блок. Нужно в математике. ------------------------------------------
\begingroup
  \catcode`\+\active\gdef+{\mathchar8235\nobreak\discretionary{}{\usefont{OT1}{cmr}{m}{n}\char43}{}}
  \catcode`\-\active\gdef-{\mathchar8704\nobreak\discretionary{}{\usefont{OMS}{cmsy}{m}{n}\char0}{}}
  \catcode`\=\active\gdef={\mathchar12349\nobreak\discretionary{}{\usefont{OT1}{cmr}{m}{n}\char61}{}}
\endgroup
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Математика}{%--------------------------------------------------------------------------------

  \block{перенос знаков в формулах}{%---------------------------------------------------------------
    \def\cdot{\mathchar8705\nobreak\discretionary{}%
      {\usefont{OMS}{cmsy}{m}{n}\char1}{}}
    \def\times{\mathchar8706\nobreak\discretionary{}%
      {\usefont{OMS}{cmsy}{m}{n}\char2}{}}
    \AtBeginDocument{%
      \mathcode`\==32768
      \mathcode`\+=32768
      \mathcode`\-=32768
    }
  }

  % шрифты -----------------------------------------------------------------------------------------
  \newcommand{\rtext}{\text}                       % корректный аналог \text
  \newcommand{\ftext}[1]{\text{\@fractextfont #1}} % корректный аналог \text для дробей
  \newcommand{\mfont}[1]{\rtext{#1}}   % математический шрифт
  \newcommand{\mfit}[1]{\mfont{\it#1}} % тот же, но курсив

  \block{frac для вывода уменьшенных числителей и знаменателей в стиле Text}{%--------------------
    \def\infrac{}%
    \def\@infrac{F}%
    \newcommand{\ifinfrac}[6]{%
      \ifmmode
        \if\infrac\@infrac
          \mathchoice{#3}{#4}{#5}{#6}
        \else
          #2
        \fi
      \else %
        #1
      \fi %
    }
    \renewcommand{\frac}[2]{{\renewcommand{\infrac}{F}\mathchoice%
      {
        {
          \renewcommand{\rtext}{\ftext}
          \mbox{$\displaystyle \textfont0=\@fracrfont \textfont1=\@fracifont \genfrac{}{}{}{0}{#1}{#2}$}%
        }
      }%diplay
      {\genfrac{}{}{}{1}{#1}{#2}}%
      {\genfrac{}{}{}{2}{#1}{#2}}%
      {\genfrac{}{}{}{3}{#1}{#2}}%
    }}
    \let\rtext=\text

    \newcounter{@MathFractionFontSize}
    \newcounter{@MathFracTextFontSize}
    \newcounter{@MathFracTextFontLine}
    \setcounter{@MathFractionFontSize}{10}
    \addtocounter{@MathFractionFontSize}{\@ptsize}
    \addtocounter{@MathFractionFontSize}{-1} %%%УМЕНЬШЕНИЕ ШРИФТА В ДРОБЯХ

    \newcommand{\@SetMathFracTextFont}{
      \setcounter{@MathFracTextFontSize}{\arabic{@MathFractionFontSize}}
      \setcounter{@MathFracTextFontLine}{\arabic{@MathFractionFontSize}}
      \addtocounter{@MathFracTextFontLine}{1}
    }
    \newcommand{\@SetMathFont}{
      \font\@fracrfont=cmr\arabic{@MathFractionFontSize}
      \font\@fracifont=cmmi\arabic{@MathFractionFontSize}
      \renewcommand{\@fractextfont}{\fontsize{\arabic{@MathFracTextFontSize}pt}{\arabic{@MathFracTextFontLine}pt}\selectfont}
    }
    \newcommand{\@fractextfont}{\fontsize{\arabic{@MathFracTextFontSize}pt}{\arabic{@MathFracTextFontLine}pt}\selectfont}
    \@SetMathFracTextFont
    \@SetMathFont
  }

  % пробелы в формулах -----------------------------------------------------------------------------
  \thinmuskip=2mu    % маленький пробел
  \medmuskip=4.5mu   % средний пробел
  \thickmuskip=4.5mu % большой пробел

  % операторы --------------------------------------------------------------------------------------
  \let\ge=\geqslant % красивое "больше или равно"
  \let\le=\leqslant % красивое "меньше или равно"
  \def\sub#1{_{\textrm{#1}}} % прямой нижний индекс
  \def\sit#1{_{\mfit{#1}}}  % косой нижний индекс
  \def\Re{\mathop{\mathrm{Re}}}% действительная часть
  \def\Im{\mathop{\mathrm{Im}}}% мнимая часть
  \def\Rot{\mathop{\mathrm{rot}}}% ротор
  \def\Div{\mathop{\mathrm{div}}}% дивергенция
  \def\Grad{\mathop{\mathrm{grad}}}% градиент

  \block{Греческие буквы}{%-------------------------------------------------------------------------
    \DeclareSymbolFont{greek}{U}{eur}{m}{n}   % определяем новый шрифт
    \SetSymbolFont{greek}{bold}{U}{eur}{b}{n} % определяем полужирное начертание
    \DeclareSymbolFontAlphabet{\greek}{greek}    % способ использования шрифта

    \DeclareMathSymbol{\alpha}     {\mathord}{greek}{"0B}
    \DeclareMathSymbol{\beta}      {\mathord}{greek}{"0C}
    \DeclareMathSymbol{\gamma}     {\mathord}{greek}{"0D}
    \DeclareMathSymbol{\delta}     {\mathord}{greek}{"0E}
    \DeclareMathSymbol{\epsilon}   {\mathord}{greek}{"0F}
    \DeclareMathSymbol{\zeta}      {\mathord}{greek}{"10}
    \DeclareMathSymbol{\eta}       {\mathord}{greek}{"11}
    \DeclareMathSymbol{\theta}     {\mathord}{greek}{"12}
    \DeclareMathSymbol{\iota}      {\mathord}{greek}{"13}
    \DeclareMathSymbol{\kappa}     {\mathord}{greek}{"14}
    \DeclareMathSymbol{\lambda}    {\mathord}{greek}{"15}
    \DeclareMathSymbol{\mu}        {\mathord}{greek}{"16}
    \DeclareMathSymbol{\nu}        {\mathord}{greek}{"17}
    \DeclareMathSymbol{\xi}        {\mathord}{greek}{"18}
    \DeclareMathSymbol{\pi}        {\mathord}{greek}{"19}
    \DeclareMathSymbol{\rho}       {\mathord}{greek}{"1A}
    \DeclareMathSymbol{\sigma}     {\mathord}{greek}{"1B}
    \DeclareMathSymbol{\tau}       {\mathord}{greek}{"1C}
    \DeclareMathSymbol{\upsilon}   {\mathord}{greek}{"1D}
    \DeclareMathSymbol{\phi}       {\mathord}{greek}{"1E}
    \DeclareMathSymbol{\chi}       {\mathord}{greek}{"1F}
    \DeclareMathSymbol{\psi}       {\mathord}{greek}{"20}
    \DeclareMathSymbol{\omega}     {\mathord}{greek}{"21}
    \DeclareMathSymbol{\varepsilon}{\mathord}{greek}{"22}
    \DeclareMathSymbol{\vartheta}  {\mathord}{greek}{"23}
    \DeclareMathSymbol{\varpi}     {\mathord}{greek}{"24}
%    \DeclareMathSymbol{\varrho}    {\mathord}{greek}{"1A}
%    \DeclareMathSymbol{\varsigma}  {\mathord}{greek}{"1B}
    \DeclareMathSymbol{\varphi}    {\mathord}{greek}{"27}

    \swap\epsilon\varepsilon % теперь по \epsilon нормальный эпсилон, а по \varepsilon - ненормальный
    \swap\phi\varphi         % теперь по \phi нормальное фи, а по \varphi - ненормальное
  }

  % специальные символы ----------------------------------------------------------------------------
  \def\EDS{\mathscr{E}}      % значек для ЭДС
  \def\const{\mathrm{const}} % константа
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Сноски}{%------------------------------------------------------------------------------------

  \newcounter{Footnote}[page]         % счетчик сносок
  \def\theFootnote{\arabic{Footnote}} % номер сноски
  \def\p@Footnote{}                   % префикс для ссылки

  \long\def\Footnote#1{% сноска
  % параметр 1 - содержание сноски
    \refstepcounter{Footnote}% новый номер сноски
    \footnote[\theFootnote]{#1}% вызываем стандартную команду
  }
  \def\Footnotemark{% метка для сноски
    \refstepcounter{Footnote}% новый номер сноски
    \footnotemark[\theFootnote]% вызываем стандартную команду
  }
  \let\Footnotetext=\footnotetext % текст сноски под общую гребенку

  \def\@makefnmark{% переопределяем вид номера сноски
    \mbox{\stars{\arabic{Footnote}}\hspace{0.1em})}% звездочки и скобочка
  }
  \setlength{\skip\footins}{\@footnote@spaceTop}% отбивка между текстом и сносками
  \def\footnoterule{% переопределяем вид линии для сносок
    \vspace{-\@footnote@spaceBot}% поднимаем линию над сносками
    \vspace{-.5pt}% место для линии
    \hrule width 48pt height .5pt% горизонтальная линия
    \vspace{\@footnote@spaceBot}% вертикальный пробел
  }
  \long\def\@makefntext#1{% переопределяем вывод текста сноски
  % параметр 1 - содержание сноски
    {\@footnote@font % устанавливаем шрифт
      \hspace{1.5em}% горизонтальный отступ
      \@makefnmark~#1
    }% заканчиваем установленный шрифт
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Оглавление}{%--------------------------------------------------------------------------------

  \def\@contents@title{% заголовок оглавления
    \noindent\@contents@titlefont\MakeUppercase{\the\@contents@name}
  }
  \newcommand{\InputContents}{% вставляет оглавление
    \clearpage% с чистой страницы
    \thispagestyle{empty}% нет колонтитулов на странице
    \vbox to 94pt{% начинаем блок
      {\@contents@title}% вставляем заголовок оглавления
    }% заканчиваем блок
    \@contents@bodyfont% устанавливаем шрифт
    \markboth% пометки для колонтитулов
    {\hfill\MakeUppercase{\the\@contents@name}\hfill}% левая
    {\hfill\MakeUppercase{\the\@contents@name}\hfill}% правая
    \@starttoc{toc}%
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Глобальные счетчики}{%-----------------------------------------------------------------------
  % Таблица зависимости счетчиков и уровней вложенности
  % @part          1 части
  % @chapter       1 главы
  % |- @paragraph  2 параграфы
  % |  |- @section 3 секция
  % |- Table       2 таблицы
  % |- Figure      2 рисунки
  % |- Equation    2 формулы

  \block{Счетчики с зависимостями}{%-----------------------------------------------------------------
    \newcounter{@part}                % счетчик частей
    \newcounter{@chapter}             % cчетчик для сброса зависящих от счетчика аналога глав
    \newcounter{@paragraph}[@chapter] % счетчик параграфов
    \newcounter{@section}[@paragraph] % счетчик секций
  }
  \block{Команды для вывода номеров}{%--------------------------------------------------------------
    \def\the@part{}      % номер части
    \def\the@chapter{}   % номер главы
    \def\the@paragraph{} % номер параграфа
    \def\the@section{}   % номер секции
  }
  \block{Префиксы для ссылок}{%---------------------------------------------------------------------
    \def\p@@part{}
    \def\p@@chapter{}
    \def\p@@paragraph{}
    \def\p@@section{}
  }
  \block{Разделители}{%---------------------------------------------------------------------
    \def\d@@part{}
    \def\d@@chapter{}
    \def\d@@paragraph{}
    \def\d@@section{}
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Конструкторы команд}{%-----------------------------------------------------------------------

  \block{Перечни}{%---------------------------------------------------------------------------------

    \newlength{\@@list@indent}% отступ для элементов списка
    \@@list@indent=0pt% изначально отступа нет
    \newcounter{Item}% счетчик элементов перечня
    \def\theItem{}% не отображаем внешний номер
    \def\prevItemNumber{}% отображение номера элемента внешнего списка
    \def\@item@deltimer{}% отделитель значка элемента вложенного списка
    \def\prevItemDeltimer{}% отделитель значка элемента внешнего списка

    \long\def\newList#1#2{% создает новый тип перечней
    % в дополнение несколько команд:
    %   \@#1@indent   - отступ для элементов списка
    %   \@#1@number   - отображение номера элемента
    %   \@#1@deltimer - отделитель значка элемента вложенного списка
    %   \@#1@item     -  значок элемента списка
    % параметр 1 - имя типа
    % параметр 2 - дополнительные параметры
    % команды для задания параметров:
    %   \indent   - задание длины отступа (по умолчанию равен абзацному)
    %   \number   - задание отображения номера элемента - \theItem (по умолчанию \prevItemNumber\prevItemDeltimer\arabic{Item})
    %   \deltimer - задание отделителя значка элемента вложенного списка (по умолчанию точка)
    %   \item     - задание отображения значка элемента (по умолчанию \theItem)\,)
      \expandafter\newlength\csname @#1@indent\endcsname % отступ для элементов списка
      \csname @#1@indent\endcsname=\parindent % задаем отступ по умолчанию равным абзацному
      \expandafter\def\csname @#1@number\endcsname{\prevItemNumber\prevItemDeltimer\arabic{Item}}% отображение номера элемента
      \expandafter\def\csname @#1@deltimer\endcsname{.}% отделитель значка элемента вложенного списка
      \expandafter\def\csname @#1@item\endcsname{\theItem.\,}% значок элемента списка
      \expandafter\def\csname #1\endcsname##1{% создание перечня
      % параметр 1 - tab (если нужно смещение)
        \def\Item####1. {% разделитель элементов
          \refstepcounter{Item}% новый номер элемента
          \ifthenelse{\equal{####1}{}}% если не передали параметр
            {\par\noindent\hspace{\@@list@indent}\csname @#1@item\endcsname} % переход на новую строку, горизонтальный отступ и значок
            {\par\noindent\hspace{\@@list@indent}####1}% переход на новую строку, горизонтальный отступ и значок
        }
        \begingroup % начинаем группу
          \edef\prevItemNumber{\theItem}% запоминаем отображение номера элемента
          \def\theItem{\csname @#1@number\endcsname}% задаем отображение номера элемента
          \edef\prevItemDeltimer{\@item@deltimer}% запоминаем отделитель значка элемента
          \def\@item@deltimer{\csname @#1@deltimer\endcsname}% задаем отделитель значка элемента
          \edef\prevItemValue{\arabic{Item}}% запоминаем значение счетчика элементов
          \setcounter{Item}{0}% сбрасываем счетчик элементов
          \ifthenelse{\equal{##1}{tab}}% если смещение нужно
            {\addtolength{\@@list@indent}{\csname @#1@indent\endcsname}}% увеличиваем отступ перед элементами
            {}% в противном случае ничего не делаем
      }
      \expandafter\def\csname end#1\endcsname{% окончание окружения
          \setcounter{Item}\prevItemValue % возвращаем значение счетчика
        \endgroup % заканчиваем группу
        \par % новый абзац
        \noindent % без отступа, если впритык
      }
      \begingroup % начало группы дополнительных параметров
        \def\indent##1{\expandafter\gdef\csname @#1@indent\endcsname{##1}}% команда для задания длины отступа
        \def\number##1{\expandafter\gdef\csname @#1@number\endcsname{##1}}% команда для задания отображения номера элемента
        \def\deltimer##1{\expandafter\gdef\csname @#1@deltimer\endcsname{##1}}% команда для задания отделителя значка элемента вложенного списка
        \def\item##1{\expandafter\gdef\csname @#1@item\endcsname{##1}}% команда для задания отображения значка элемента
        #2% дополнительные параметры
      \endgroup % конец группы дополнительных параметров

      \@package@message{List #1 created}% сообщение о создании типа списков
    }

    \newList{List}{% простой список из отступов
      \number{}% не отображаем номер
      \deltimer{}% нет номера - не нужен и отделитель
      \item{\theItem}% просто ничего не делаем
    }
    \newList{Itemize}{% перечень с дефисами
      \number{}% не отображаем номер
      \deltimer{}% нет номера - не нужен и отделитель
      \item{---\,}% просто ничего не делаем
    }
    \newList{DotList}{% перечень с точками
      \number{}% не отображаем номер
      \deltimer{}% нет номера - не нужен и отделитель
      \item{\textbullet\,}% просто ничего не делаем
    }
    \newList{Enumerate}{% перечень с арабскими номерами
    }
   \newList{EnumerateBr}{% перечень с цифрами и скобками
      \item{\theItem)\;}% просто ничего не делаем
    }
  }
  \block{Рубрикация}{%------------------------------------------------------------------------------
    \def\newCounter#1[#2]#3{% создает новый тип счетчика
    % команды:
    %   \mark#1[1] - метка
    %   \ref#1[1]  - сслыка
    %   \page#1[1] - ссылка на страницу
    % параметр 1 - имя счетчика
    % параметр 2 - зависимость счетчика
    % параметр 3 - дополнительные параметры
    % команды для задания параметров:
    %   \prefix    - задание префикса ссылки (по умолчанию пустой)
    %   \delimiter - задание разделителя счетчика и зависящих от него - параметр \d@<имя_счетчика> (по умолчанию точка)
    %   \number    - отображение номера (по умолчанию \the#2\d@#2\arabic{#1})
      \ifthenelse{\equal{#2}{}}
        {% если нет зависимости
          \newcounter{#1}% создаем счетчик без зависимости
          \expandafter\def\csname the#1\endcsname{\arabic{#1}}% переопределяем отображение номера счетчика
        }
        {% если зависимость есть
          \newcounter{#1}[#2]% создаем счетчик с зависимостью
          \expandafter\def\csname the#1\endcsname{\csname the#2\endcsname\csname d@#2\endcsname\arabic{#1}}% переопределяем отображение номера счетчика
        }
      \expandafter\def\csname p@#1\endcsname{}% префикс ссылки
      \expandafter\def\csname d@#1\endcsname{.}% префикс ссылки
      \expandafter\def\csname mark#1\endcsname##1{\label{#1:##1}}% команда для метки
      \expandafter\def\csname ref#1\endcsname##1{\ref{#1:##1}}% команда для ссылки
      \expandafter\def\csname page#1\endcsname##1{\MakeLowercase{\the\@page@name}~\pageref{#1:##1}}% команда для ссылки на страницу
      \begingroup % начало группы дополнительных параметров
        \def\prefix##1{\expandafter\gdef\csname p@#1\endcsname{##1}}% команда для задания префикса
        \def\delimiter##1{\expandafter\gdef\csname p@#1\endcsname{##1}}% команда для задания префикса
        \def\number##1{\expandafter\gdef\csname the#1\endcsname{##1}}% команда для задания отображения номера
        #3% дополнительные параметры
      \endgroup % конец группы дополнительных параметров
      \@package@message{counter #1 created}% сообщение о создании счетчика
    }
    \def\newPart#1#2#3{% создает новый тип глав
    % счетчики:
    %   #1 - счетчик, не зависящий ни от чего
    % длины:
    %   \@#1@contents@spaceTop - верхний отступ в оглавлении
    %   \@#1@contents@spaceBot - нижний отступ в оглавлении
    %   \@#1@spaceTop          - верхний отступ перед заголовком
    %   \@#1@spaceMid          - расстояние от заголовка до названия
    % команды:
    %   \@#1@titlefont         - шрифт для заголовка
    %   \@#1@namefont          - шрифт для названия
    %   \@#1@bodyfont          - шрифт для содержания
    %   \@#1@addtocontents[1]  - вставка в оглавление
    %   \@#1@headmark@left[1]  - левая отметка в колонтитулы
    %   \@#1@headmark@right[1] - правая отметка в колонтитулы
    %   \@#1@title             - заголовок
    %   \@#1@name[1]           - название
    %   \#1                    - вывод в тексте
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
    % параметр 3 - сокращенное имя для колонтитулов
      \newCounter{#1}[]{% счетчик
        \number{\Roman{#1}}% номер римскими цифрами
      }
      \expandafter\newlength\csname @#1@contents@spaceTop\endcsname % верхний отступ в оглавлении
      \expandafter\newlength\csname @#1@contents@spaceBot\endcsname % нижний отступ в оглавлении
      \expandafter\newlength\csname @#1@spaceTop\endcsname % верхний отступ перед заголовком
      \expandafter\newlength\csname @#1@spaceMid\endcsname % расстрояние от заголовка до названия
      \csname @#1@contents@spaceTop\endcsname=\@@part@contents@spaceTop % верхний отступ в оглавлении
      \csname @#1@contents@spaceBot\endcsname=\@@part@contents@spaceBot % нижний отступ в оглавлении
      \csname @#1@spaceTop\endcsname=\@@part@spaceTop % верхний отступ перед заголовком
      \csname @#1@spaceMid\endcsname=\@@part@spaceMid % расстояние от заголовка до названия
      \expandafter\let\csname @#1@titlefont\endcsname=\@@part@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@namefont\endcsname=\@@part@namefont % шрифт для названия
      \expandafter\let\csname @#1@bodyfont\endcsname=\@main@bodyfont % шрифт для содержания
      \expandafter\def\csname @#1@addtocontents\endcsname##1{% вставка в оглавление
      % параметр 1 - название
        \vspace{\csname @#1@contents@spaceTop\endcsname}% вертикальный отступ
        \protect\begin{center}% начинаем выравнивание по центру
          \bfseries % полужирным
          \csname the#1\endcsname.\hspace{1.5em}\MakeUppercase{##1}% номер название
        \protect\end{center}% заканчиванием выравнивание по центру
        \protect\nopagebreak % запрещаем переход на новую страницу
        \vspace{\csname @#1@contents@spaceBot\endcsname} % вертикальный отступ
        \protect\nopagebreak % запрещаем переход на новую страницу
      }
      \expandafter\def\csname @#1@headmark@left\endcsname##1{% левая отметка в колонтитулы
      % параметр 1 - название
        \hfill % заполнение слева
        \MakeUppercase{##1}% название
        \hfill % заполнение справа
        \MakeUppercase{#3}~\csname the#1\endcsname % сокращенное название и номер
      }
      \expandafter\def\csname @#1@headmark@right\endcsname##1{% правая отметка в колонтитулы
      % параметр 1 - название
        \MakeUppercase{#3}~\csname the#1\endcsname % сокращенное название и номер
        \hfill % заполнение слева
        \MakeUppercase{##1}% название
        \hfill % заполнение справа
      }
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname#2~\csname the#1\endcsname % выводим заголовок и номер
      }
      \expandafter\def\csname @#1@name\endcsname##1{% название
      % параметр 1 - текст названия
        \csname @#1@namefont\endcsname\uppercase{##1}% выводим название
      }

      \expandafter\def\csname #1\endcsname##1##2##3{% вставка в текст
      % параметр 1 - название в текст
      % параметр 2 - название в оглавление
      % параметр 3 - название в колонтитулы
        \clearpage % с нечетной страницы
        \thispagestyle{empty}% нет колонтитулов на странице
        \null\vspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \refstepcounter{#1}% новый номер
        \stepcounter{@part}% сбрасываем счетчики, зависящие от части
        \def\the@part{\csname the#1\endcsname}% заносим нужный номер
        \def\d@@part{\csname d@#1\endcsname}% заносим нужный разделитель
        \begin{center}% начинаем окружение для центрирования
          \csname @#1@title\endcsname % вставляем заголовок
          \par\vspace{\csname @#1@spaceMid\endcsname}% вертикальный отступ
          \noindent\csname @#1@name\endcsname{##1}% вставляем название
        \end{center}% заканчиваем окружение для центрирования
        \newpage % очищаем страницу
        \csname @#1@bodyfont\endcsname % выбираем шрифт
        \markboth % пометки для колонтитулов
          {\csname @#1@headmark@left\endcsname{##3}}% левая
          {\csname @#1@headmark@right\endcsname{##3}}% правая
        \addtocontents{toc}{\csname @#1@addtocontents\endcsname{##2}}% добавляем в оглавление
      }

      \@package@message{Part #1 created}% сообщение о создании типа
    }
    \def\newSubpart#1#2{% создает новый тип подчастей
    % длины:
    %   \@#1@contents@spaceTop - верхний отступ в оглавлении
    %   \@#1@contents@spaceBot - нижний отступ в оглавлении
    %   \@#1@spaceTop          - верхний отступ перед заголовком
    %   \@#1@spaceBox          - высота бокса с заголовком
    % команды:
    %   \@#1@titlefont      - шрифт для заголовка
    %   \@#1@bodyfont       - шрифт для содержания
    %   \@#1@addtocontents  - вставка в оглавление
    %   \@#1@headmark@left  - левая отметка в колонтитулы
    %   \@#1@headmark@right - правая отметка в колонтитулы
    %   \@#1@title          - заголовок
    %   \#1                 - вывод в тексте
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
      \expandafter\newlength\csname @#1@contents@spaceTop\endcsname % верхний отступ в оглавлении
      \expandafter\newlength\csname @#1@contents@spaceBot\endcsname % нижний отступ в оглавлении
      \expandafter\newlength\csname @#1@spaceTop\endcsname % верхний отступ перед заголовком
      \expandafter\newlength\csname @#1@spaceBox\endcsname % высота бокса с заголовком
      \csname @#1@contents@spaceTop\endcsname=\@@subpart@contents@spaceTop % верхний отступ в оглавлении
      \csname @#1@contents@spaceBot\endcsname=\@@subpart@contents@spaceBot % нижний отступ в оглавлении
      \csname @#1@spaceTop\endcsname=\@@subpart@spaceTop % верхний отступ перед заголовком
      \csname @#1@spaceBox\endcsname=\@@subpart@spaceBox % высота бокса с заголовком
      \expandafter\let\csname @#1@titlefont\endcsname=\@@subpart@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@bodyfont\endcsname=\@main@bodyfont % шрифт для содержания
      \expandafter\def\csname @#1@addtocontents\endcsname{% вставка в оглавление
        \par\vspace{\csname @#1@contents@spaceTop\endcsname}% вертикальный отступ
        \noindent % запрещаем абзацный отступ
        { % начинаем изменение шрифта
          \hspace{-6pt} {#2}% заголовок аналога главы
          \dotfill % заполняем все точками
          \protect\makebox[1.8em]{\protect\hfill\thepage}% блок с номером страницы
        }% заканчиваем изменение шрифта
        \protect\par % на новую строчку
        \vspace{\csname @#1@contents@spaceBot\endcsname}% вертикальный отступ
      }
      \expandafter\def\csname @#1@headmark@left\endcsname{% левая отметка в колонтитулы
        \hfill % заполнение слева
        \MakeUppercase{#2}% вывод заголовка
        \hfill % заполнение справа
      }
      \expandafter\def\csname @#1@headmark@right\endcsname{% правая отметка в колонтитулы
        \hfill % заполнение слева
        \MakeUppercase{#2}% вывод заголовка
        \hfill % заполнение справа
      }
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname\MakeUppercase{#2 к третьему изданию}% выводим заголовок
      }

      \expandafter\def\csname #1\endcsname\par{% вставка в текст
        \clearpage % с чистой страницы
        \thispagestyle{empty}% нет колонтитулов на странице
        \addvspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \stepcounter{@chapter}% сбрасываем счетчики, зависящие от главы
        \def\the@chapter{}% не выводим номер главы
        \def\d@@chapter{}% не выводим разделитель
        \vbox to \csname @#1@spaceBox\endcsname{% начинаем блок
          \noindent\csname @#1@title\endcsname % вставляем заголовок
        }% заканчиваем блок
        \csname @#1@bodyfont\endcsname % выбираем шрифт
        \noindent % далее без отступа
        \markboth % пометки для колонтитулов
          {\csname @#1@headmark@left\endcsname}% левая
          {\csname @#1@headmark@right\endcsname}% правая
        \addtocontents{toc}{\csname @#1@addtocontents\endcsname}% добавляем в оглавление
      }

      \@package@message{Subpart #1 created}% сообщение о создании типа
    }
    \def\newChapter#1#2#3{% создает новый тип глав
    % счетчики:
    %   #1 - счетчик, не зависящий ни от чего
    % длины:
    %   \@#1@contents@spaceTop - верхний отступ в оглавлении
    %   \@#1@contents@spaceMid - отступ от заголовка до названия в оглавлении
    %   \@#1@contents@spaceBot - нижний отступ в оглавлении
    %   \@#1@spaceTop          - верхний отступ перед заголовком
    %   \@#1@spaceBox          - высота бокса с заголовком
    %   \@#1@spaceMid          - расстояние от линейки до названия
    %   \@#1@spaceBot          - нижний отступ от названия
    % команды:
    %   \@#1@titlefont         - шрифт для заголовка
    %   \@#1@namefont          - шрифт для названия
    %   \@#1@bodyfont          - шрифт для содержания
    %   \@#1@addtocontents[1]  - вставка в оглавление
    %   \@#1@headmark@left[1]  - левая отметка в колонтитулы
    %   \@#1@headmark@right[1] - правая отметка в колонтитулы
    %   \@#1@doatstart         - добавочные команды
    %   \@#1@title             - заголовок
    %   \@#1@name[1]           - название
    %   \#1                    - вывод в тексте
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
    % параметр 3 - сокращенное имя для колонтитулов
      \newCounter{#1}[]{\number{\arabic{#1}}}% счетчик
      \expandafter\newlength\csname @#1@contents@spaceTop\endcsname % верхний отступ в оглавлении
      \expandafter\newlength\csname @#1@contents@spaceMid\endcsname % отступ от заголовка до названия в оглавлении
      \expandafter\newlength\csname @#1@contents@spaceBot\endcsname % нижний отступ в оглавлении
      \expandafter\newlength\csname @#1@spaceTop\endcsname % верхний отступ перед заголовком
      \expandafter\newlength\csname @#1@spaceBox\endcsname % высота бокса с заголовком
      \expandafter\newlength\csname @#1@spaceMid\endcsname % расстрояние от линейки до названия
      \expandafter\newlength\csname @#1@spaceBot\endcsname % нижний отступ от названия
      \csname @#1@contents@spaceTop\endcsname=\@@chapter@contents@spaceTop % верхний отступ в оглавлении
      \csname @#1@contents@spaceMid\endcsname=\@@chapter@contents@spaceMid % отступ от заголовка до названия в оглавлении
      \csname @#1@contents@spaceBot\endcsname=\@@chapter@contents@spaceBot % нижний отступ в оглавлении
      \csname @#1@spaceTop\endcsname=\@@chapter@spaceTop % верхний отступ перед заголовком
      \csname @#1@spaceBox\endcsname=\@@chapter@spaceBox % высота бокса с заголовком
      \csname @#1@spaceMid\endcsname=\@@chapter@spaceMid % расстояние от линейки до названия
      \csname @#1@spaceBot\endcsname=\@@chapter@spaceBot % нижний отступ от названия
      \expandafter\let\csname @#1@titlefont\endcsname=\@@chapter@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@namefont\endcsname=\@@chapter@namefont % шрифт для названия
      \expandafter\let\csname @#1@bodyfont\endcsname=\@main@bodyfont % шрифт для содержания
      \expandafter\def\csname @#1@addtocontents\endcsname##1{% вставка в оглавление
      % параметр 1 - название
        \par\vspace{\csname @#1@contents@spaceTop\endcsname}% вертикальный отступ
        \noindent % запрещаем абзацный отступ
        {#2}~\csname the#1\endcsname. % слово "глава" и номер
        %\protect\par % на новую строчку
        \protect\nopagebreak % запрещаем переход на новую страницу
        %\hspace{3pt}
        %\vspace{\csname @#1@contents@spaceMid\endcsname}% вертикальный отступ
        \protect\nopagebreak % запрещаем переход на новую страницу
        \noindent % запрещаем абзацный отступ
        {\bfseries % начинаем изменение шрифта
%          \MakeUppercase
          ~{##1}% название главы
          \dotfill % заполняем все точками
          \protect\makebox[1.8em]{\protect\hfill\thepage}% блок с номером страницы
        }% заканчиваем изменение шрифта
        \protect\par % на новую строчку
        \protect\nopagebreak % запрещаем переход на новую страницу
        \vspace{\csname @#1@contents@spaceBot\endcsname}% вертикальный отступ
        \protect\nopagebreak % запрещаем переход на новую страницу
      }
      \expandafter\def\csname @#1@headmark@left\endcsname##1{% левая отметка в колонтитулы
      % параметр 1 - название
        \hfill % заполнение слева
        \MakeUppercase{##1}% название
        \hfill % заполнение справа
        \MakeUppercase{#3}~\csname the#1\endcsname % сокращенное название и номер
      }
      \expandafter\def\csname @#1@headmark@right\endcsname##1{% правая отметка в колонтитулы
      % параметр 1 - название
        \MakeUppercase{#3}~\csname the#1\endcsname % сокращенное название и номер
        \hfill % заполнение слева
        \MakeUppercase{##1}% название
        \hfill % заполнение справа
      }
      \expandafter\def\csname @#1@doatstart\endcsname{}% добавочные команды
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname\uppercase{\so{#2}}~\csname the#1\endcsname% выводим заголовок и номер
      }
      \expandafter\def\csname @#1@name\endcsname##1{% название
      % параметр 1 - текст названия
        \csname @#1@namefont\endcsname\uppercase{##1}% выводим название
      }

      \expandafter\def\csname #1\endcsname##1##2##3\par{% вставка в текст
      % параметр 1 - название в текст
      % параметр 2 - название в оглавление
      % параметр 3 - название в колонтитулы
        \clearpage % с чистой страницы
        \thispagestyle{empty}% нет колонтитулов на странице
        \addvspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \refstepcounter{#1}% новый номер
        \stepcounter{@chapter}% сбрасываем счетчики, зависящие от главы
        \def\the@chapter{\csname the#1\endcsname}% заносим нужный номер
        \def\d@@chapter{\csname d@#1\endcsname}% заносим нужный разделитель
        \vbox to \csname @#1@spaceBox\endcsname{% начинаем блок
          \noindent\csname @#1@title\endcsname % вставляем заголовок
        }% заканчиваем блок
        \hrule height .5pt% горизонтальная линейка
        \par\vspace{\csname @#1@spaceMid\endcsname}% вертикальный отступ
        \noindent\csname @#1@name\endcsname{##1}% вставляем название
        \par\vspace{\csname @#1@spaceBot\endcsname}% вертикальный отступ
        \csname @#1@bodyfont\endcsname % выбираем шрифт
        \noindent % далее без отступа
        \markboth % пометки для колонтитулов
          {\csname @#1@headmark@left\endcsname{##3}}% левая
          {\csname @#1@headmark@right\endcsname{##3}}% правая
        \addtocontents{toc}{\csname @#1@addtocontents\endcsname{##2}}% добавляем в оглавление
        \csname @#1@doatstart\endcsname % добавочные команды
      }

      \@package@message{Chapter #1 created}% сообщение о создании типа
    }
    \def\newTheorem#1#2#3{% создает новое окружение а-ля теорема
    % счетчики:
    %   #1 - счетчик, зависящий от главы
    % длины:
    %   \@#1@spaceTop  - отступ перед окружением
    %   \@#1@spaceBot  - отступ после окружения
    % команды:
    %   \@#1@titlefont     - шрифт для заголовка
    %   \@#1@namefont      - шрифт для названия
    %   \@#1@conditionfont - шрифт для условия
    %   \@#1@hinttitlefont - шрифт для заголовка подсказки
    %   \@#1@hintfont      - шрифт для подсказки
    %   \@#1@title         - заголовок
    % окружения:
    %   #1 - вывод в тексте
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
    % параметр 3 - дополнительные параметры
      \newCounter{#1}[@chapter]{}% счетчик
      \expandafter\newlength\csname @#1@spaceTop\endcsname % отступ перед окружением
      \expandafter\newlength\csname @#1@spaceBot\endcsname % отступ после окружения
      \csname @#1@spaceTop\endcsname=\@@theorem@spaceTop % отступ перед окружением
      \csname @#1@spaceBot\endcsname=\@@theorem@spaceBot % отступ после окружения
      \expandafter\let\csname @#1@titlefont\endcsname=\@@theorem@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@namefont\endcsname=\@@theorem@namefont % шрифт для названия
      \expandafter\let\csname @#1@conditionfont\endcsname=\@@theorem@conditionfont % шрифт для содержания
      \expandafter\let\csname @#1@hinttitlefont\endcsname=\@@theorem@hinttitlefont % шрифт для заголовка подсказки
      \expandafter\let\csname @#1@hintfont\endcsname=\@@theorem@hintfont % шрифт для подсказки
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname#2\hspace{.5em}\csname the#1\endcsname% выводим заголовок и номер
      }
      \expandafter\long\expandafter\def\csname @#1@name\endcsname##1{% названиие
      % параметр 1 - текст названия
        \csname @#1@namefont\endcsname(##1)% выводим название
      }
      \expandafter\long\expandafter\def\csname @#1@hint\endcsname##1{% подсказка
      % параметр 1 - текст подсказки
        \csname @#1@hinttitlefont\endcsname\the\@hint@name:~\csname @#1@hintfont\endcsname##1% выводим подсказку
      }

      \expandafter\long\expandafter\def\csname#1\endcsname##1 {% начало окружения для вставки в текст
      % параметр 1 - название
        \par\vspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \refstepcounter{#1}% новый номер
        \ifthenelse{\equal{##1}{}}% есть ли назание
          {% если нет
            \csname @#1@title\endcsname. % вставляем заголовок c точкой
          }%
          {% если есть
            \csname @#1@title\endcsname~% вставляем заголовок с промежутком
            \csname @#1@name\endcsname{##1}. % вставляем название c точкой
          }%
        \begingroup % начало группы
          \def\hint{\csname @#1@hint\endcsname}% команда для подсказки
          \csname @#1@conditionfont\endcsname % изменяем шрифт
      }
      \expandafter\long\expandafter\def\csname end#1\endcsname{% окончание окружеия
        \endgroup % конец группы
        \par\vspace{\csname @#1@spaceBot\endcsname}% вертикальный отступ
      }

      \@package@message{Theorem #1 created}% сообщение о создании типа
    }
    \def\newParagraph#1#2#3{% создает новый тип параграфов
    % счетчики:
    %   #1 - счетчик, зависящий от главы
    % длины:
    %   \@#1@contents@spaceTop - верхний отступ в оглавлении
    %   \@#1@contents@spaceBot - нижний отступ в оглавлении
    %   \@#1@contents@widthNum - ширина поля для номера
    %   \@#1@contents@widthNam - ширина поля для названия
    %   \@#1@spaceTop          - верхний отступ перед заголовком
    %   \@#1@spaceBot          - нижний отступ от названия
    % команды:
    %   \@#1@titlefont        - шрифт для заголовка
    %   \@#1@namefont         - шрифт для названия
    %   \@#1@bodyfont         - шрифт для содержания
    %   \@#1@addtocontents[1] - вставка в оглавление
    %   \@#1@headmark[1]      - отметка в колонтитулы
    %   \@#1@title            - заголовок
    %   \@#1@name[1]          - название
    %   \#1                   - вставка в текст
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
    % параметр 3 - сокращенное имя для колонтитулов
      \newCounter{#1}[@chapter]{}% счетчик
      \expandafter\newlength\csname @#1@contents@spaceTop\endcsname % верхний отступ в оглавлении
      \expandafter\newlength\csname @#1@contents@spaceBot\endcsname % нижний отступ в оглавлении
      \expandafter\newlength\csname @#1@contents@widthNum\endcsname % ширина поля для номера
      \expandafter\newlength\csname @#1@contents@widthNam\endcsname % ширина поля для названия
      \expandafter\newlength\csname @#1@spaceTop\endcsname % верхний отступ перед заголовком
      \expandafter\newlength\csname @#1@spaceBot\endcsname % нижний отступ от заголовка
      \csname @#1@contents@spaceTop\endcsname=\@@paragraph@contents@spaceTop % верхний отступ в оглавлении
      \csname @#1@contents@spaceBot\endcsname=\@@paragraph@contents@spaceBot % нижний отступ в оглавлении
      \expandafter\def\csname @#1@contents@widthNum\endcsname{2.5em}% ширина поля для номера
      \expandafter\def\csname @#1@contents@widthNam\endcsname{\textwidth-\csname @#1@contents@widthNum\endcsname}% ширина поля для названия
      \csname @#1@spaceTop\endcsname=\@@paragraph@spaceTop % верхний отступ перед заголовком
      \csname @#1@spaceBot\endcsname=\@@paragraph@spaceBot % нижний отступ от заголовка
      \expandafter\let\csname @#1@titlefont\endcsname=\@@paragraph@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@namefont\endcsname=\@@paragraph@namefont % шрифт для названия
      \expandafter\let\csname @#1@bodyfont\endcsname=\@main@bodyfont % шрифт для содержания
      \expandafter\def\csname @#1@addtocontents\endcsname##1{% вставка в оглавление
      % параметр 1 - название
        \par\vspace{\csname @#1@contents@spaceTop\endcsname}% вертикальный отступ
        \protect\noindent % без абзацного отступа
        \protect\parbox[t]{\csname @#1@contents@widthNum\endcsname}{#2\csname the#1\endcsname.}% блок с номером
        \protect\parbox[t]{\csname @#1@contents@widthNam\endcsname}{##1\dotfill\protect\makebox[1.8em]{\hfill\thepage}}% блок с названием, точками и номером страницы
        \vspace{\csname @#1@contents@spaceBot\endcsname}% вертикальный отступ
      }
      \expandafter\def\csname @#1@headmark\endcsname##1{% отметка в колонтитулы
      % параметр 1 - название
        \MakeUppercase{#3}\csname the#1\endcsname % сокращенное название и номер
        \hfill % заполнение слева
        \MakeUppercase{##1}% название
        \hfill % заполнение справа
      }
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname#2\csname the#1\endcsname.% выводим заголовок и номер
      }
      \expandafter\def\csname @#1@name\endcsname##1{% название
      % параметр 1 - текст названия
        \csname @#1@namefont\endcsname##1% выводим название
      }

      \expandafter\def\csname #1\endcsname##1##2##3\par{% вставка в текст
      % параметр 1 - название в текст
      % параметр 2 - название в оглавление
      % параметр 3 - название в колонтитулы
        \par\vspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \refstepcounter{#1}% новый номер
        \stepcounter{@paragraph}% сбрасываем счетчики, зависящие от параграфа
        \def\the@paragraph{\csname the#1\endcsname}% заносим нужный номер
        \def\d@@paragraph{\csname d@#1\endcsname}% заносим нужный разделитель
        \noindent % без абзацного отступа
        \noindent\csname @#1@title\endcsname % вставляем заголовок
        ~% промежуточек
        \csname @#1@name\endcsname{##1}% вставляем название
        \nopagebreak % запрещаем переход на новую страницу
        \par\vspace{\csname @#1@spaceBot\endcsname}% вертикальный отступ
        \nopagebreak % запрещаем переход на новую страницу
        \csname @#1@bodyfont\endcsname % выбираем шрифт
        \noindent % далее без отступа
        \markright{\csname @#1@headmark\endcsname{##3}}% правая пометка для колонтитулов
        \addtocontents{toc}{\csname @#1@addtocontents\endcsname{##2}}% добавляем в оглавление
      }

      \@package@message{Paragraph #1 created}% сообщение о создании типа
    }
    \def\newSection#1#2#3{% создает новый тип разделов
    % счетчики:
    %   #1 - счетчик, зависящий от параграфа
    % длины:
    %   \@#1@spaceTop - верхний отступ перед заголовком
    % команды:
    %   \@#1@titlefont - шрифт для заголовка
    %   \@#1@namefont  - шрифт для названия
    %   \@#1@bodyfont  - шрифт для содержания
    %   \@#1@title     - заголовок
    %   \@#1@name[1]   - название
    %   \#1            - вставка в текст
    % параметр 1 - название типа
    % параметр 2 - имя в заголовок
      \newCounter{#1}[@paragraph]{}% счетчик
      \expandafter\newlength\csname @#1@spaceTop\endcsname % верхний отступ перед заголовком
      \csname @#1@spaceTop\endcsname=\@@section@spaceTop % верхний отступ перед заголовком
      \expandafter\let\csname @#1@titlefont\endcsname=\@@section@titlefont % шрифт для заголовка
      \expandafter\let\csname @#1@namefont\endcsname=\@@section@namefont % шрифт для названия
      \expandafter\let\csname @#1@bodyfont\endcsname=\@main@bodyfont % шрифт для содержания
      \expandafter\def\csname @#1@title\endcsname{% заголовок
        \csname @#1@titlefont\endcsname#2\csname the#1\endcsname.% выводим заголовок и номер с точкой
      }
      \expandafter\def\csname @#1@name\endcsname##1{% название
      % параметр 1 - текст названия
        \csname @#1@namefont\endcsname##1% выводим название
      }

      \expandafter\def\csname #1\endcsname##1{% вставка в текст
      % параметр 1 - название в текст
        \ifhmode % если в горизонтальном режиме
          \null % чтобы было обо что опереться
          \par % переходим в вертикальный режим
        \fi
        \vspace{\csname @#1@spaceTop\endcsname}% вертикальный отступ
        \refstepcounter{#1}% новый номер
        \stepcounter{@section}% сбрасываем счетчики, зависящие от параграфа
        \def\the@section{\csname the#1\endcsname}% заносим нужный номер
        \def\d@@section{\csname d@#1\endcsname}% заносим нужный разделитель
        \csname @#1@title\endcsname % вставляем заголовок
        ~% промежуточек
        \csname @#1@name\endcsname{##1.}% вставляем название с точкой
        \csname @#1@bodyfont\endcsname % выбираем шрифт
      }

      \@package@message{Section #1 created}% сообщение о создании типа
    }
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Таблицы}{%-----------------------------------------------------------------------------------

  \newCounter{Table}[@chapter]{% счетчик для таблиц
    \prefix{\MakeLowercase{\the\@table@shortname}\:}% задаем префикс
  }

  \def\@table@last@type{}% тип последней таблицы
  \newtoks{\@table@last@params}% параметры последней таблицы
  \newtoks{\@table@last@name}% имя последней таблицы

  \arrayrulewidth=.5pt% ширина линеек таблиц
  \extrarowheight=3pt% дополнительная высота строк таблиц

  \def\@table@title#1{% заголовок таблицы
  % параметр 1 - текст названия
    \noindent{\@table@titlefont\expandafter\so\expandafter{\the\@table@name\,\theTable}.~}{\@table@namefont #1}% заголовок и название
  }
  \def\@table@continue@title{% заголовок продолжения таблицы
    % todo: заменить слово продолжение на что-нибудь
    \noindent{\@table@titlefont\expandafter\so\expandafter{\the\@table@name\,\theTable~}(продолжение).}~{\@table@namefont\the\@table@last@name}% заголовок и название
  }

  \def\@TableBody#1{% начало тела таблицы для остальных окружений
  % параметр 1 - параметры таблицы
    \@table@last@params=\expandafter{#1}% запоминаем параметры таблицы
    \par\vspace{\@table@spaceMid}% вертикальный отступ
    \nopagebreak % запрещаем переход на новую страницу
    \noindent % без абзацного отступа
    \hfill % заполнение слева
    \@table@bodyfont % выбираем шрифт
    \begin{longtable}{#1}% начинаем окружение таблицы
  }
  \def\end@TableBody{% окончание тела таблицы для остальных окружений
    \end{longtable}% заканчиваем окружение таблицы
    \hfill\null % заполнение справа
    \par\vspace{\@table@spaceBot}% вертикальный отступ
  }

  \newenvironment{TableBody}[1]{% тело таблицы без заголовка
  % параметр 1 - параметры таблицы
    \begin{@TableBody}{#1}% начинаем построение таблицы
      }% тело окружения
      {% окончание окружения
    \end{@TableBody}% заканчиваем построение таблицы
    \gdef\@table@last@type{body}% тип таблицы - тушка
  }

  \long\def\Table#1#2 #3{% начало таблицы
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - параметры колонок для таблицы
    \@table@last@name=\expandafter{#1}% запоминаем название таблицы
    \vspace{\@table@spaceTop}% вертикальный отступ
    \refstepcounter{Table}% новый номер таблицы
    \markTable{#2}% делаем метку
    \@table@title{#1}% заголовок и номер таблицы
    \nopagebreak % запрещаем переход на новую страницу
    \begin{@TableBody}{#3}% начинаем построение таблицы
  }
  \def\endTable{% конец таблицы
    \end{@TableBody}% заканчиваем построение таблицы
    \def\@table@last@type{standard}% тип последней таблицы
  }

  \long\def\TableRotated#1#2 #3#4\end#{% повернутая таблица
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - параметры колонок для таблицы
  % параметр 4 - тело окружения
    \@table@last@name=\expandafter{#1}% запоминаем имя таблицы
    \refstepcounter{Table}% новый номер таблицы
    \markTable{#2}% делаем метку
    \begin{table}[p]% на отдельную страницу
      \noindent % запрещаем отступ
      \rotatebox{90}{% поворачиваем
        \parbox{\textheight}{% бокс с таблицей
          \@table@title{#1}% заголовок и номер таблицы
          \nopagebreak % запрещаем переход на новую страницу
          \begin{@TableBody}{#3}% начинаем построение таблицы
            #4% тело таблицы
          \end{@TableBody}% заканчиваем построение таблицы
        }%
      }%
    \end{table}%
    \gdef\@table@last@type{rotated}% повернутая таблицы
    \end %для корректного завершения окружения
  }

%  todo: переделать все нафиг
%  \long\def\ContinueTable#1\end#{% продолжение таблицы
%  % параметр 1 - тело окружения
%    \ifthenelse{\equal{\@table@last@type}{body}}
%    {% если тип - тушка
%      \expandafter\@TableBody\expandafter{\@table@last@params}{#1}% построение таблицы
%    }
%    {\ifthenelse{\equal{\@table@last@type}{standard}}
%      {% если стандартная таблица
%        \vspace{\@table@spaceTop}% вертикальный отступ
%        \@table@continue@title % заголовок и номер таблицы
%        \nopagebreak % запрещаем переход на новую страницу
%        \expandafter\@TableBody\expandafter{\@table@last@params}{#1}% построение таблицы
%      }
%      {\ifthenelse{\equal{\@table@last@type}{rotated}}
%        {% если повернутая таблица
%          \begin{table}[p]% на отдельную страницу
%            \noindent % запрещаем отступ
%            \rotatebox{90}{% поворачиваем
%              \parbox{\textheight}{% бокс с таблицей
%                \@table@continue@title % заголовок и номер таблицы
%                \nopagebreak % запрещаем переход на новую страницу
%                \expandafter\@TableBody\expandafter{\@table@last@params}{#1}% построение таблицы
%              }%
%            }%
%          \end{table}%
%        }
%        {}
%      }
%    }
%    \end %для корректного завершения окружения
%  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Картинки}{%----------------------------------------------------------------------------------

  \newCounter{Figure}[@chapter]{% счетчик для картинок
    \prefix{\MakeLowercase{\the\@figure@shortname}\,}% задаем префикс
  }

  \def\@figure@title#1{% заголовок рисунка
  % параметр 1 - текст названия
      \noindent{\@figure@titlefont\the\@figure@name\,\theFigure.}~{\@figure@namefont#1}% заголовок и название
  }
  \def\@figure@inputtitle#1{% способ вставки заголовка в команде Figure
  % параметр 1 - текст названия
    \par\vspace{\@figure@spaceMid}% вертикальный пропуск
    \@figure@title{#1}% номер рисунка и название
  }

  \long\def\Figure#1#2 [#3]#4#5#6{% просто рисунок с подписью
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - выравнивание во вертикали (t,c,b)
  % параметр 4 - ширина картинки
  % параметр 5 - высота картинки
  % параметр 6 - имя файла
    \refstepcounter{Figure}% новый номер элемента
    \markFigure{#2}% помечаем рисунок
    \parbox[#3]{#4}{% начинаем блок для рисунка и подписи
      \noindent\includegraphics[width=#4, height=#5]{#6}% вставляем картинку
      \@figure@inputtitle{#1}% вставляем номер и название
    }% заканчиваем блок с рисунком и подписью
  }
  \long\def\iFigure#1#2 #3#4#5{% рисунок для вклейки
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - ширина картинки
  % параметр 4 - высота картинки
  % параметр 5 - имя файла
    \refstepcounter{Figure}% новый номер картинки
    \markFigure{#2}% помечаем рисунок
  }
  \long\def\hFigure#1#2 #3#4#5{% центрированый рисунок и растянутая подпись
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - ширина картинки
  % параметр 4 - высота картинки
  % параметр 5 - имя файла
    \ifhmode % если в горизонтальном режиме
      \linebreak % растягиваем строчку
      \par % переходим в вертикальный режим
      \vspace{-2ex}% возвращаемся наверх
    \fi % заканчиваем проверку режима
    \vspace{\@figure@spaceTop}% вертикальный отступ
    \noindent % без абзацного отступа
    \refstepcounter{Figure}% новый номер картинки
    \markFigure{#2}% помечаем рисунок
    \parbox{\textwidth}{% блок с картинкой и подписью
      \hfill % заполнение слева
      \includegraphics[width=#3, height=#4]{#5}% вставляем картинку
      \hfill\null %заполнение справа
      \par\vspace{\@figure@spaceMid}% вертикальный пропуск
      \noindent % без абзацного отступа
      \@figure@title{#1}% номер и название рисунка
    }% заканчиваем блок с текстом
    \vspace{\@figure@spaceBot}% вертикальный отступ
    \noindent\null % без отступа, если впритык
}
  \long\def\cFigure#1#2 #3#4#5{% центрированый рисунок и подпись
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - ширина картинки
  % параметр 4 - высота картинки
  % параметр 5 - имя файла
    \ifhmode % если в горизонтальном режиме
      \linebreak % растягиваем строчку
      \par % переходим в вертикальный режим
      \vspace{-2ex}% возвращаемся наверх
    \fi % заканчиваем проверку режима
    \vspace{\@figure@spaceTop}% вертикальный отступ
    \noindent % без абзацного отступа
    \refstepcounter{Figure}% новый номер картинки
    \markFigure{#2}% помечаем рисунок
    \parbox{\textwidth}{% блок с картинкой и подписью
      \hfill % заполнение слева
      \includegraphics[width=#3, height=#4]{#5}% вставляем картинку
      \hfill\null % заполнение справа
      \par\vspace{\@figure@spaceMid}% вертикальный пропуск
      \hfill % заполнение слева
      \@figure@title{#1}% номер и название рисунка
      \hfill\null % заполнение справа
    }% заканчиваем блок с текстом
    \vspace{\@figure@spaceBot}% вертикальный отступ
    \noindent\null % без отступа, если впритык
}
  \long\def\fFigure#1#2 #3#4#5{% плавающий рисунок
  % параметр 1 - название
  % параметр 2 - метка
  % параметр 3 - ширина картинки
  % параметр 4 - высота картинки
  % параметр 5 - имя файла
    \begin{wrapfigure}{o}{#3}% начинаем окружение для рисунка
      \refstepcounter{Figure}% новый номер элемента
      \markFigure{#2}% помечаем рисунок
      \vspace{\@figure@float@spaceTop} % вертикальный пропуск
      \noindent\includegraphics[width=#3, height=#4]{#5}% вставляем картинку
      \par\vspace{\@figure@spaceMid}% вертикальный пропуск
      \noindent\parbox{#3}{% блок с текстом
        \@figure@title{#1}% номер рисунка и комментарий
      }% заканчиваем блок с текстом
      \vspace{\@figure@float@spaceBot}% вертикальный пропуск
    \end{wrapfigure}% заканчиваем окружение для рисунка
  }

  \block{Вставка нескольких картинок}{%-------------------------------------------------------------

    \def\hFigures{% начало окружения для вставки нескольких картинок с растягиванием по краям
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi % заканчиваем проверку режима
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начинаем блок с картинками
    }
    \def\endhFigures{% оконание окружения для вставки нескольких картинок с растягиванием по краям
        \linebreak % для растягивания
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \end{minipage}% заканчиваем блок с картинками
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }

    \def\cFigures{% начало окружения для вставки нескольких картинок с выравниванием по центру
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi % заканчиваем проверку режима
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начинаем блок с картинками
        \hfill % заполнение слева
    }
    \def\endcFigures{% окончание окружения для вставки нескольких картинок с выравниванием по центру
        \hfill\null % заполнение справа
      \end{minipage}% заканчиваем блок с картинками
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }

    \newcounter{@figures@first}% номер первой картинки
    \newcounter{@figures@last}% номер последней картинки

    \long\def\hbFigures{% начало окружения для для вставки нескольких картинок с растягиванием по краям и подписями снизу
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi % заканчиваем проверку режима
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начинаем блок с картинками
        \setcounter{@figures@first}{\arabic{Figure}}% номер первой картинки
        \setcounter{@figures@last}{\arabic{Figure}}% номер последней картинки
        \def\@figure@inputtitle##1{% переопределяем способ вставки заголовка в команде Figure
        % параметр 1 - текст названия
          \stepcounter{@figures@last}% на одну картинку больше
          \expandafter\gdef\csname @figures@name\arabic{@figures@last}\endcsname{##1}% запоминаем название
        }
    }
    \long\def\endhbFigures{% окончание окружения для для вставки нескольких картинок с растягиванием по краям и подписями снизу
        \linebreak % для растягивания
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
        \vspace{\@figure@spaceMid}% вертикальный отступ
        \loop % по всем картинкам
          \ifnum\arabic{@figures@first} < \arabic{@figures@last}% если еще не все картинки обработали
          \stepcounter{@figures@first}% на одну картинку больше
          \setcounter{Figure}{\arabic{@figures@first}}% выводимый номер
          \@figure@title{\csname @figures@name\arabic{@figures@first}\endcsname}% выводим название картинки
          \par % переход на новую строку
        \repeat %
      \end{minipage}% заканчиваем блок с картинками
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }

    \long\def\cbFigures{% начало окружения для вставки нескольких картинок с выравниванием по центру и подписями снизу
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi % заканчиваем проверку режима
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начинаем блок с картинками
        \setcounter{@figures@first}{\arabic{Figure}}% номер первой картинки
        \setcounter{@figures@last}{\arabic{Figure}}% номер последней картинки
        \def\@figure@inputtitle##1{% переопределяем способ вставки заголовка в команде Figure
        % параметр 1 - текст названия
          \stepcounter{@figures@last}% на одну картинку больше
          \expandafter\gdef\csname @figures@name\arabic{@figures@last}\endcsname{##1}% запоминаем название
        }
        \hfill % заполнение слева
    }
    \long\def\endcbFigures{% окончание окружения для вставки нескольких картинок с выравниванием по центру и подписями снизу
        \hfill\null % заполнение справа
        \par % переходим в вертикальный режим
        \vspace{\@figure@spaceMid}% вертикальный отступ
        \loop % по всем картинкам
          \ifnum\arabic{@figures@first} < \arabic{@figures@last}% если еще не все картинки обработали
          \stepcounter{@figures@first}% на одну картинку больше
          \setcounter{Figure}{\arabic{@figures@first}}% выводимый номер
          \@figure@title{\csname @figures@name\arabic{@figures@first}\endcsname}% выводим название картинки
          \par % переход на новую строку
        \repeat %
      \end{minipage}% заканчиваем блок с картинками
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }
  }
  \block{Картинки - блоки}{%------------------------------------------------------------------------
    \newtoks{\@figure@current@name}% текущее имя картинки

    \long\def\FigureBox#1#2 [#3]#4{% просто рисунок с подписью
    % параметр 1 - название
    % параметр 2 - метка
    % параметр 3 - выравнивание во вертикали (t,c,b)
    % параметр 4 - ширина картинки
      \refstepcounter{Figure}% новый номер элемента
      \markFigure{#2}% помечаем рисунок
      \begin{minipage}[#3]{#4}% начинаем блок для рисунка и подписи
        \@figure@current@name=\expandafter{#1}% запоминаем имя
    }
    \def\endFigureBox{% просто рисунок с подписью
        \ifhmode % если в горизонтальном режиме
          \linebreak % растягиваем строчку
          \par % переходим в вертикальный режим
          \vspace{-2ex}% возвращаемся наверх
        \fi
        \vspace{\@figure@spaceMid}% вертикальный пропуск
        \@figure@title{\the\@figure@current@name}% номер и название рисунка
      \end{minipage}% заканчиваем блок с рисунком и подписью
    }

    \long\def\hFigureBox#1#2 #3{% начало центрированного рисунока и растянутой подписи
    % параметр 1 - название
    % параметр 2 - метка
    % параметр 3 - ширина
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \refstepcounter{Figure}% новый номер картинки
      \markFigure{#2}% помечаем рисунок
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начанием блок с картинкой и подписью
        \@figure@current@name=\expandafter{#1}% запоминаем имя
        \hfill % заполнение слева
        \begin{minipage}{#3}% начинаем блок с картинкой
    }
    \def\endhFigureBox{% окончание центрированного рисунка и растянутой подписи
          \null % чтобы было обо что опереться
        \end{minipage}% заканчиваем блок с картинкой
        \hfill\null %заполнение справа
        \par\vspace{\@figure@spaceMid}% вертикальный пропуск
        \noindent % без абзацного отступа
        \@figure@title{\the\@figure@current@name}% номер и название рисунка
      \end{minipage}% заканчиваем блок с картинкой и подписью
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }

    \long\def\cFigureBox#1#2 #3{% начало центрированных рисунка и подписи
    % параметр 1 - название
    % параметр 2 - метка
    % параметр 3 - ширина
      \ifhmode % если в горизонтальном режиме
        \linebreak % растягиваем строчку
        \par % переходим в вертикальный режим
        \vspace{-2ex}% возвращаемся наверх
      \fi
      \vspace{\@figure@spaceTop}% вертикальный отступ
      \refstepcounter{Figure}% новый номер картинки
      \markFigure{#2}% помечаем рисунок
      \noindent % без абзацного отступа
      \begin{minipage}{\textwidth}% начанием блок с картинкой и подписью
        \@figure@current@name=\expandafter{#1}% запоминаем имя
        \hfill % заполнение слева
        \begin{minipage}{#3}% начинаем блок с картинкой
    }
    \def\endcFigureBox{% окончание центрированных рисунка и подписи
          \null % чтобы было обо что опереться
        \end{minipage}% заканчиваем блок с картинкой
        \hfill\null %заполнение справа
        \par\vspace{\@figure@spaceMid}% вертикальный пропуск
        \hfill % заполнение слева
        \@figure@title{\the\@figure@current@name}% номер и название рисунка
        \hfill\null %заполнение справа
      \end{minipage}% заканчиваем блок с картинкой и подписью
      \vspace{\@figure@spaceBot}% вертикальный отступ
      \noindent\null % без отступа, если впритык
    }

    \long\def\fFigureBox#1#2 #3{% начало плавающего рисунка
    % параметр 1 - название
    % параметр 2 - метка
    % параметр 3 - ширина картинки
      \refstepcounter{Figure}% новый номер элемента
      \markFigure{#2}% помечаем рисунок
      \begin{wrapfigure}{o}{#3}% начинаем плавающее окружение
        \vspace{\@figure@float@spaceTop} % вертикальный пропуск
        \begin{minipage}{#3}% начинаем блок с картинкой и подписью
          \@figure@current@name=\expandafter{#1}% запоминаем имя
    }
    \def\endfFigureBox{% окончание плавающего рисунка
          \null % чтобы было обо что опереться
          \par\vspace{\@figure@spaceMid}% вертикальный пропуск
          \@figure@title{\the\@figure@current@name}% номер и название рисунка
        \end{minipage}% заканчиваем блок с картинкой и подписью
        \vspace{\@figure@float@spaceBot}% вертикальный пропуск
      \end{wrapfigure}% заканчиваем плавающее окружение
    }
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Формулы}{%-----------------------------------------------------------------------------------

  \newCounter{Equation}[@chapter]{}% счетчик для формул

  \def\eqMark#1{% отметка для нумерованной формулы
  % параметр 1 - имя метки
    \refstepcounter{Equation}% новый номер формулы
    \markEquation{#1}% метка
    \eqno(\theEquation)% вставляем номер
  }

  \newtoks{\@multline@current@mark}% текущеая метка многострочной формулы
  \def\@multlineMark#1{% пометка для многострочной формулы
    \addtocounter{Equation}{1}% новый номер формулы
    \global\@multline@current@mark=\expandafter{#1}% запоминаем имя метки
    \mfont{\parbox{2.86em}{\parbox{3.81em}{\hfill$(\theEquation)$}\hspace{-1.13em}}}% выводим номер
  }

  \def\Multline#1\end#{% многострочная формула
  % параметр 1 - тело формулы
    \@multline@current@mark={}% сбрасываем имя метки
    \begingroup %начинаем группу
      \let\eqMark=\@multlineMark % переопределяем способ пометки
      \begin{multline*}% начинаем многострочную формулу
        #1% тело формулы
      \end{multline*}% заканчиваем многострочную формулу
    \endgroup % заканчиваем группу
    \ifthenelse{\equal{\the\@multline@current@mark}{}}{}{% если метка не пустая
      \addtocounter{Equation}{-1}% возвращаемся на предыдущий номер
      \refstepcounter{Equation}% увеличиваем номер для ссылки
      \markEquation{\the\@multline@current@mark}% метка
    }%
    \end % для корректного завершения окружения
  }
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
\block{Список литературы}{%-------------------------------------------------------------------------

  \newCounter{Book}[]{}% счетчик книг

  \newlength{\@book@numberWidth}% ширина поля с номером книги
  \@book@numberWidth=2.1em
  \newlength{\@book@descriptionWidth}% ширина поля с описанием книги
  \@book@descriptionWidth=\textwidth
  \addtolength{\@book@descriptionWidth}{-\@book@numberWidth}

  \newcommand{\Book}[3]{% книжка
  % параметр 1 - метка
  % параметр 2 - авторы
  % параметр 3 - описание
    \refstepcounter{Book}% новый номер книги
    \markBook{#1}% метка
    \noindent % без абзацного отступа
    \parbox[t]{\@book@numberWidth}{\theBook.}% блок с номером книги
    \parbox[t]{\@book@descriptionWidth}{{\itshape#2} #3}% блок с описанием
    \par % начинаем новый абзац
  }

  \newSubpart{Booklist}{\the\@booklist@name}% создаем новую команду для списка книг
}
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
% Разное -------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------
\def\sslash{\mbox{/\hspace{-2pt}/}\relax}% двойной слеш для списка книг

\newcounter{@stars}% счетчик количества звездочек
\def\stars#1{% рисует звездочки
% параметр 1 - количество звездочек
  \setcounter{@stars}{0}% количество нарисованных звездочек
  \loop % цикл
    \ifnum\arabic{@stars} < #1 % если нарисованы не все звездочки
    *% рисуем звездочку
    \stepcounter{@stars}% увеличиваем количество нарисованных звездочек
  \repeat %
}

\long\def\hide#1{\makebox[1pt]{\color{white}#1}\hspace{-1pt}}
