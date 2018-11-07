---
title: "Reading Tabular Data into DataFrames"
teaching: 10
exercises: 10
questions:
- "How can I read tabular data?"
objectives:
- "Import the Pandas library."
- "Use Pandas to load a simple CSV data set."
- "Get some basic information about a Pandas DataFrame."
keypoints:
- "Use the Pandas library to get basic statistics out of tabular data."
- "Use `index_col` to specify that a column's values should be used as row headings."
- "Use `DataFrame.info` to find out more about a dataframe."
- "The `DataFrame.columns` variable stores information about the dataframe's columns."
- "Use `DataFrame.T` to transpose a dataframe."
- "Use `DataFrame.describe` to get summary statistics about data."
---
## Use the Pandas library to do statistics on tabular data.

*   Pandas is a widely-used Python library for statistics, particularly on tabular data.
*   Borrows many features from R's dataframes.
    *   A 2-dimenstional table whose columns have names
        and potentially have different data types.
*   Load it with `import pandas`.
*   Read a Comma Separate Values (CSV) data file with `pandas.read_csv`.
    *   Argument is the name of the file to be read.
    *   Assign result to a variable to store the data that was read.

~~~
import pandas

data = pandas.read_csv('data/jarvis_data_subset2.csv')
print(data)
~~~
{: .python}
~~~
           jid  encut     epsx     epsy     epsz      fin_en  form_enp  \
0  JVASP-11997    500  21.0673  29.1228  17.6066  -12.242175     0.025
1  JVASP-12002   1200  13.8023  38.1854  35.5515  -42.395911    -1.184
2  JVASP-12010   1250   6.3933   6.9466   6.3796 -103.756610    -2.086
3  JVASP-12023    550   6.0838   6.0838   6.5652    0.756760    -0.204

       gv    icsd  kp_leng      kv  mbj_gap    mepsx    mepsy    mepsz  \
0  19.993  609832       65  34.556   0.6495  15.0619  14.9875  12.4788
1  25.667    None       55  78.478   0.0083  16.5818  61.5222  53.1874
2  52.420  158256       50  75.067   2.4642   5.2402   5.8492   5.3897
3   5.947   28230       60  17.478   2.7025   4.5320   4.5323   4.9101

        mpid  op_gap
0     mp-158  0.0221
1   mp-24242  0.0038
2  mp-510584  1.9202
3  mp-567809  1.2599
~~~
{: .output}

*   The columns in a dataframe are the observed variables, and the rows are the observations.
*   Pandas uses backslash `\` to show wrapped lines when output is too wide to fit the screen.

> ## File Not Found
>
> Our lessons store their data files in a `data` sub-directory,
> which is why the path to the file is `data/jarvis_data_subset2.csv`.
> If you forget to include `data/`,
> or if you include it but your copy of the file is somewhere else,
> you will get a [runtime error]({{ page.root }}/05-error-messages/)
> that ends with a line like this:
>
> ~~~
> OSError: File b'jarvis_data_subset2.csv' does not exist
> ~~~
> {: .error}
{: .callout}

## The Data

The data used in these examples is from the [JARVIS
project](https://github.com/usnistgov/jarvis) run at NIST by [Kamal
Choudary](https://github.com/knc6), see [this
example](https://github.com/usnistgov/jarvis/blob/master/jarvis/db/static/jarvis_dft-explore.ipynb)
for more details. The data is generated from a series of
[VASP](https://www.vasp.at/), a density functional theory code,
calculations and then postprocessed by JARVIS tools. The labeled
columns can be interpred as

 * `jid`: JARVIS calculation ID
 * `icsd`: International Crystal Structure Database (ICSD) ID
 * `mpid`: Materials Project structure ID
 * `form_enp`: formation energy per atom (eV/atom)
 * `op_gap`: OptB88vdW functional based bandgap (eV)
 *  `mbj_gap`: TBmBJ functional based bandgap (eV)
 * `kv`: Voigt bulk mod. (GPa)
 * `gv`: Shear bulk mod. (GPa)
 * `epsx`: Static dielctric function value in x-direction based on OptB88vdW (no unit)
 * `mepsx`: Static dielctric function value in x-direction based on TBmBJ (no unit)
 * `kp_leng`: Kpoint automatic line density obtained after automatic
   convergence (Angstrom), substract 25 because 5 extra points were
   taken during convergence
 * `encut`: Plane wave cut-off value obtained after automatic convergence
 * `formula`: the reduced formula of the material


['encut', 'epsx', 'fin_en', 'form_enp', 'gv', 'icsd', 'jid', 'kp_leng', 'kv', 'mbj_gap', 'mepsx', 'mepsy', 'mpid', 'op_gap', 'formula']


To get more details about the materials go to

  * https://www.ctcms.nist.gov/~knc6/jsmol/JVASP-11997

for example, use the `jid` column value in the last section of the
path.

## Use `index_col` to specify that a column's values should be used as row headings.

*   Row headings are numbers (0 and 1 in this case).
*   Really want to index by the material data ID.
*   Pass the name of the column to `read_csv` as its `index_col` parameter to do this.

~~~
data = pandas.read_csv('data/jarvis_data_subset2.csv', index_col='jid')
print(data)
~~~
{: .python}
~~~
             encut     epsx     epsy     epsz      fin_en  form_enp      gv  \
jid
JVASP-11997    500  21.0673  29.1228  17.6066  -12.242175     0.025  19.993
JVASP-12002   1200  13.8023  38.1854  35.5515  -42.395911    -1.184  25.667
JVASP-12010   1250   6.3933   6.9466   6.3796 -103.756610    -2.086  52.420
JVASP-12023    550   6.0838   6.0838   6.5652    0.756760    -0.204   5.947

               icsd  kp_leng      kv  mbj_gap    mepsx    mepsy    mepsz  \
jid
JVASP-11997  609832       65  34.556   0.6495  15.0619  14.9875  12.4788
JVASP-12002    None       55  78.478   0.0083  16.5818  61.5222  53.1874
JVASP-12010  158256       50  75.067   2.4642   5.2402   5.8492   5.3897
JVASP-12023   28230       60  17.478   2.7025   4.5320   4.5323   4.9101

                  mpid  op_gap
jid
JVASP-11997     mp-158  0.0221
JVASP-12002   mp-24242  0.0038
JVASP-12010  mp-510584  1.9202
JVASP-12023  mp-567809  1.2599
~~~
{: .output}

## Use `DataFrame.info` to find out more about a dataframe.

~~~
data.info()
~~~
{: .python}
~~~
<class 'pandas.core.frame.DataFrame'>
Index: 4 entries, JVASP-11997 to JVASP-12023
Data columns (total 16 columns):
encut       4 non-null int64
epsx        4 non-null float64
epsy        4 non-null float64
epsz        4 non-null float64
fin_en      4 non-null float64
form_enp    4 non-null float64
gv          4 non-null float64
icsd        4 non-null object
kp_leng     4 non-null int64
kv          4 non-null float64
mbj_gap     4 non-null float64
mepsx       4 non-null float64
mepsy       4 non-null float64
mepsz       4 non-null float64
mpid        4 non-null object
op_gap      4 non-null float64
dtypes: float64(12), int64(2), object(2)
memory usage: 544.0+ bytes
~~~
{: .output}

*   This is a `DataFrame`
*   Four rows named `'JVASP-XXXXX'`
*   Sixteen columns, most of which has two actual 64-bit floating point values.
    *   We will talk later about null values, which are used to represent missing observations.
*   Uses 544 bytes of memory.

## The `DataFrame.columns` variable stores information about the dataframe's columns.

*   Note that this is data, *not* a method.
    *   Like `math.pi`.
    *   So do not use `()` to try to call it.
*   Called a *member variable*, or just *member*.

~~~
print(data.columns)
~~~
{: .python}
~~~
Index(['encut', 'epsx', 'epsy', 'epsz', 'fin_en', 'form_enp', 'gv', 'icsd',
       'kp_leng', 'kv', 'mbj_gap', 'mepsx', 'mepsy', 'mepsz', 'mpid',
       'op_gap'],
      dtype='object')
~~~
{: .output}

## Use `DataFrame.T` to transpose a dataframe.

*   Sometimes want to treat columns as rows and vice versa.
*   Transpose (written `.T`) doesn't copy the data, just changes the program's view of it.
*   Like `columns`, it is a member variable.

~~~
print(data.T)
~~~
{: .python}
~~~
jid      JVASP-11997 JVASP-12002 JVASP-12010 JVASP-12023
encut            500        1200        1250         550
epsx         21.0673     13.8023      6.3933      6.0838
epsy         29.1228     38.1854      6.9466      6.0838
epsz         17.6066     35.5515      6.3796      6.5652
fin_en      -12.2422    -42.3959    -103.757     0.75676
form_enp       0.025      -1.184      -2.086      -0.204
gv            19.993      25.667       52.42       5.947
icsd          609832        None      158256       28230
kp_leng           65          55          50          60
kv            34.556      78.478      75.067      17.478
mbj_gap       0.6495      0.0083      2.4642      2.7025
mepsx        15.0619     16.5818      5.2402       4.532
mepsy        14.9875     61.5222      5.8492      4.5323
mepsz        12.4788     53.1874      5.3897      4.9101
mpid          mp-158    mp-24242   mp-510584   mp-567809
op_gap        0.0221      0.0038      1.9202      1.2599
~~~
{: .output}

## Use `DataFrame.describe` to get summary statistics about data.

DataFrame.describe() gets the summary statistics of only the columns that have numerical data.
All other columns are ignored, unless you use the argument `include='all'`.
~~~
print(data.describe())
~~~
{: .python}
~~~
             encut       epsx      epsy       epsz      fin_en  form_enp  \
count     4.000000   4.000000   4.00000   4.000000    4.000000   4.00000
mean    875.000000  11.836675  20.08465  16.525725  -39.409484  -0.86225
std     405.174859   7.113228  16.10339  13.727155   46.550550   0.96981
min     500.000000   6.083800   6.08380   6.379600 -103.756610  -2.08600
25%     537.500000   6.315925   6.73090   6.518800  -57.736086  -1.40950
50%     875.000000  10.097800  18.03470  12.085900  -27.319043  -0.69400
75%    1212.500000  15.618550  31.38845  22.092825   -8.992441  -0.14675
max    1250.000000  21.067300  38.18540  35.551500    0.756760   0.02500

             gv    kp_leng         kv   mbj_gap      mepsx      mepsy  \
count   4.00000   4.000000   4.000000  4.000000   4.000000   4.000000
mean   26.00675  57.500000  51.394750  1.456125  10.353975  21.722800
std    19.46222   6.454972  30.153868  1.331228   6.350760  26.937217
min     5.94700  50.000000  17.478000  0.008300   4.532000   4.532300
25%    16.48150  53.750000  30.286500  0.489200   5.063150   5.519975
50%    22.83000  57.500000  54.811500  1.556850  10.151050  10.418350
75%    32.35525  61.250000  75.919750  2.523775  15.441875  26.621175
max    52.42000  65.000000  78.478000  2.702500  16.581800  61.522200

           mepsz    op_gap
count   4.000000  4.000000
mean   18.991500  0.801500
std    23.058401  0.949633
min     4.910100  0.003800
25%     5.269800  0.017525
50%     8.934250  0.641000
75%    22.655950  1.424975
max    53.187400  1.920200
~~~
{: .output}

*   Not particularly useful with just two records,
    but very helpful when there are thousands.

> ## Reading Other Data
>
> Read the data in `gapminder_gdp_americas.csv`
> (which should be in the same directory as `gapminder_gdp_oceania.csv`)
> into a variable called `americas`
> and display its summary statistics.
>
> > ## Solution
> > To read in a CSV, we use `pandas.read_csv` and pass the filename 'data/gapminder_gdp_americas.csv' to it. We also once again pass the
> > column name 'country' to the parameter `index_col` in order to index by country:
> > ~~~
> > americas = pandas.read_csv('data/gapminder_gdp_americas.csv', index_col='country')
> > ~~~
> >{: .python}
> {: .solution}
{: .challenge}



> ## Inspecting Data.
>
> After reading the data for the Americas,
> use `help(americas.head)` and `help(americas.tail)`
> to find out what `DataFrame.head` and `DataFrame.tail` do.
>
> 1.  What method call will display the first three rows of this data?
> 2.  What method call will display the last three columns of this data?
>     (Hint: you may need to change your view of the data.)
>
> > ## Solution
> > 1. We can check out the first five rows of `americas` by executing `americas.head()` (allowing us to view the head
> > of the DataFrame). We can specify the number of rows we wish to see by specifying the parameter `n` in our call
> > to `americas.head()`. To view the first three rows, execute:
> >
> > ~~~
> > americas.head(n=3)
> > ~~~
> >{: .python}
> >
> > The output is then
> > ~~~
> >          continent  gdpPercap_1952  gdpPercap_1957  gdpPercap_1962  \
> >country
> >Argentina  Americas     5911.315053     6856.856212     7133.166023
> >Bolivia    Americas     2677.326347     2127.686326     2180.972546
> >Brazil     Americas     2108.944355     2487.365989     3336.585802
> >
> >           gdpPercap_1967  gdpPercap_1972  gdpPercap_1977  gdpPercap_1982  \
> >country
> >Argentina     8052.953021     9443.038526    10079.026740     8997.897412
> >Bolivia       2586.886053     2980.331339     3548.097832     3156.510452
> >Brazil        3429.864357     4985.711467     6660.118654     7030.835878
> >
> >           gdpPercap_1987  gdpPercap_1992  gdpPercap_1997  gdpPercap_2002  \
> >country
> >Argentina     9139.671389     9308.418710    10967.281950     8797.640716
> >Bolivia       2753.691490     2961.699694     3326.143191     3413.262690
> >Brazil        7807.095818     6950.283021     7957.980824     8131.212843
> >
> >           gdpPercap_2007
> >country
> >Argentina    12779.379640
> >Bolivia       3822.137084
> >Brazil        9065.800825
> > ~~~
> >{: .output}
> > 2. To check out the last three rows of `americas`, we would use the command, `americas.tail(n=3)`,
> > analogous to `head()` used above. However, here we want to look at the last three columns so we need
> > to change our view and then use `tail()`. To do so, we create a new DataFrame in which rows and
> > columns are switched
> >
> > ~~~
> > americas_flipped = americas.T
> > ~~~
> >{: .python}
> >
> > We can then view the last three columns of `americas` by viewing the last three rows of `americas_flipped`:
> > ~~~
> > americas_flipped.tail(n=3)
> > ~~~
> >{: .python}
> > The output is then
> > ~~~
> > country        Argentina  Bolivia   Brazil   Canada    Chile Colombia  \
> > gdpPercap_1997   10967.3  3326.14  7957.98  28954.9  10118.1  6117.36
> > gdpPercap_2002   8797.64  3413.26  8131.21    33329  10778.8  5755.26
> > gdpPercap_2007   12779.4  3822.14   9065.8  36319.2  13171.6  7006.58
> >
> > country        Costa Rica     Cuba Dominican Republic  Ecuador    ...     \
> > gdpPercap_1997    6677.05  5431.99             3614.1  7429.46    ...
> > gdpPercap_2002    7723.45  6340.65            4563.81  5773.04    ...
> > gdpPercap_2007    9645.06   8948.1            6025.37  6873.26    ...
> >
> > country          Mexico Nicaragua   Panama Paraguay     Peru Puerto Rico  \
> > gdpPercap_1997   9767.3   2253.02  7113.69   4247.4  5838.35     16999.4
> > gdpPercap_2002  10742.4   2474.55  7356.03  3783.67  5909.02     18855.6
> > gdpPercap_2007  11977.6   2749.32  9809.19  4172.84  7408.91     19328.7
> >
> > country        Trinidad and Tobago United States  Uruguay Venezuela
> > gdpPercap_1997             8792.57       35767.4  9230.24   10165.5
> > gdpPercap_2002             11460.6       39097.1     7727   8605.05
> > gdpPercap_2007             18008.5       42951.7  10611.5   11415.8
> > ~~~
> >{: .output}
> > Note: we could have done the above in a single line of code by 'chaining' the commands:
> > ~~~
> > americas.T.tail(n=3)
> > ~~~
> >{: .python}
> {: .solution}
{: .challenge}

> ## Reading Files in Other Directories
>
> The data for your current project is stored in a file called `microbes.csv`,
> which is located in a folder called `field_data`.
> You are doing analysis in a notebook called `analysis.ipynb`
> in a sibling folder called `thesis`:
>
> ~~~
> your_home_directory
> +-- field_data/
> |   +-- microbes.csv
> +-- thesis/
>     +-- analysis.ipynb
> ~~~
> {: .output}
>
> What value(s) should you pass to `read_csv` to read `microbes.csv` in `analysis.ipynb`?
>
> > ## Solution
> > We need to specify the path to the file of interest in the call to `pandas.read_csv`. We first need to 'jump' out of
> > the folder `thesis` using '../' and then into the folder `field_data` using 'field_data/'. Then we can specify the filename `microbes.csv.
> > The result is as follows:
> > ~~~
> > data_microbes = pandas.read_csv('../field_data/microbes.csv')
> > ~~~
> >{: .python}
> {: .solution}
{: .challenge}

> ## Writing Data
>
> As well as the `read_csv` function for reading data from a file,
> Pandas provides a `to_csv` function to write dataframes to files.
> Applying what you've learned about reading from files,
> write one of your dataframes to a file called `processed.csv`.
> You can use `help` to get information on how to use `to_csv`.
> > ## Solution
> > In order to write the DataFrame `americas` to a file called `processed.csv`, execute the following command:
> > ~~~
> > americas.to_csv('processed.csv')
> > ~~~
> >{: .python}
> > For help on `to_csv`, you could execute, for example,
> > ~~~
> > help(americas.to_csv)
> > ~~~
> >{: .python}
> > Note that `help(to_csv)` throws an error! This is a subtlety and is due to the fact that `to_csv` is NOT a function in
> > and of itself and the actual call is `americas.to_csv`.
> >
> {: .solution}
{: .challenge}
