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

data = pandas.read_csv('data/jarvis_subset.csv')
print(data)
~~~
{: .python}
~~~
      epsx     epsy     epsz      fin_en  form_enp      gv    icsd  kp_leng  \
0  21.0673  29.1228  17.6066  -12.242175     0.025  19.993  609832       65
1   6.3933   6.9466   6.3796 -103.756610    -2.086  52.420  158256       50
2   6.0838   6.0838   6.5652    0.756760    -0.204   5.947   28230       60
3   7.0316   6.3127   5.2274  -35.585506    -1.768  37.120   27393       55
4   4.6738   4.7460   4.7722   -4.653860    -0.830   9.047   65198       55

       kv  mbj_gap    mepsx    mepsy    mepsz       mpid  op_gap          jid  \
0  34.556   0.6495  15.0619  14.9875  12.4788     mp-158  0.0221  JVASP-11997
1  75.067   2.4642   5.2402   5.8492   5.3897  mp-510584  1.9202  JVASP-12010
2  17.478   2.7025   4.5320   4.5323   4.9101  mp-567809  1.2599  JVASP-12023
3  54.633   2.2441   6.0366   5.5260   4.6886  mp-570157  1.8723  JVASP-12027
4  16.378   3.7113   3.6685   3.7637   3.7977  mp-570219  2.3104  JVASP-12028

  formula
0      As
1    MoO3
2     AgI
3   ZrBrN
4   InBr3
~~~
{: .output}

*   The columns in a dataframe are the observed variables, and the rows are the observations.
*   Pandas uses backslash `\` to show wrapped lines when output is too wide to fit the screen.

> ## File Not Found
>
> Our lessons store their data files in a `data` sub-directory,
> which is why the path to the file is `data/jarvis_subset.csv`.
> If you forget to include `data/`,
> or if you include it but your copy of the file is somewhere else,
> you will get a [runtime error]({{ page.root }}/05-error-messages/)
> that ends with a line like this:
>
> ~~~
> OSError: File b'jarvis_subset.csv' does not exist
> ~~~
> {: .error}
{: .callout}

## The Data

The data used in these examples is from the [JARVIS
project](https://github.com/usnistgov/jarvis) run at NIST by [Kamal
Choudary](https://github.com/knc6), see [this
example](https://github.com/usnistgov/jarvis/blob/master/jarvis/db/static/jarvis_dft-explore.ipynb)
for more details. The data is generated using JARVIS to automate a
series of [VASP](https://www.vasp.at/) (a density functional theory
code) calculations and then post-process the results for each
individual material, see [these
publications](https://www.ctcms.nist.gov/~knc6/pubs.html) for more
details. The labeled columns in the dataframe refer to,

 * `jid`: JARVIS calculation ID
 * `icsd`: International Crystal Structure Database (ICSD) ID
 * `mpid`: Materials Project structure ID
 * `form_enp`: Formation energy per atom (eV/atom)
 * `op_gap`: OptB88vdW functional based bandgap (eV)
 *  `mbj_gap`: TBmBJ functional based bandgap (eV)
 * `kv`: Voigt bulk mod. (GPa)
 * `gv`: Shear bulk mod. (GPa)
 * `epsx`: Static dielctric function value in x-direction based on OptB88vdW (no unit)
 * `mepsx`: Static dielctric function value in x-direction based on TBmBJ (no unit)
 * `kp_leng`: Kpoint automatic line density obtained after automatic
   convergence (Angstrom)
 * `encut`: Plane wave cut-off value obtained after automatic convergence
 * `formula`: the reduced formula of the material

To get more details about each material in the dataframe, go to the
[JARVIS website](https://www.ctcms.nist.gov/~knc6/JARVIS.html) using
the `jid` value. For example, to get details about `As`
(`JVASP-11997`), go to
[https://www.ctcms.nist.gov/~knc6/jsmol/JVASP-11997](https://www.ctcms.nist.gov/~knc6/jsmol/JVASP-11997).

The page shows post-processed results from VASP calculations.

## Use `index_col` to specify that a column's values should be used as row headings.

*   Row headings are numbers (0 and 1 in this case).
*   Really want to index by the material data ID.
*   Pass the name of the column to `read_csv` as its `index_col` parameter to do this.

~~~
data = pandas.read_csv('data/jarvis_subset.csv', index_col='jid')
print(data)
~~~
{: .python}
~~~
               epsx     epsy     epsz      fin_en  form_enp      gv    icsd  \
jid
JVASP-11997  21.0673  29.1228  17.6066  -12.242175     0.025  19.993  609832
JVASP-12010   6.3933   6.9466   6.3796 -103.756610    -2.086  52.420  158256
JVASP-12023   6.0838   6.0838   6.5652    0.756760    -0.204   5.947   28230
JVASP-12027   7.0316   6.3127   5.2274  -35.585506    -1.768  37.120   27393
JVASP-12028   4.6738   4.7460   4.7722   -4.653860    -0.830   9.047   65198

             kp_leng      kv  mbj_gap    mepsx    mepsy    mepsz       mpid  \
jid
JVASP-11997       65  34.556   0.6495  15.0619  14.9875  12.4788     mp-158
JVASP-12010       50  75.067   2.4642   5.2402   5.8492   5.3897  mp-510584
JVASP-12023       60  17.478   2.7025   4.5320   4.5323   4.9101  mp-567809
JVASP-12027       55  54.633   2.2441   6.0366   5.5260   4.6886  mp-570157
JVASP-12028       55  16.378   3.7113   3.6685   3.7637   3.7977  mp-570219

             op_gap formula
jid
JVASP-11997  0.0221      As
JVASP-12010  1.9202    MoO3
JVASP-12023  1.2599     AgI
JVASP-12027  1.8723   ZrBrN
JVASP-12028  2.3104   InBr3
~~~
{: .output}

## Use `DataFrame.info` to find out more about a dataframe.

~~~
data.info()
~~~
{: .python}
~~~
<class 'pandas.core.frame.DataFrame'>
Index: 5 entries, JVASP-11997 to JVASP-12028
Data columns (total 16 columns):
epsx        5 non-null float64
epsy        5 non-null float64
epsz        5 non-null float64
fin_en      5 non-null float64
form_enp    5 non-null float64
gv          5 non-null float64
icsd        5 non-null int64
kp_leng     5 non-null int64
kv          5 non-null float64
mbj_gap     5 non-null float64
mepsx       5 non-null float64
mepsy       5 non-null float64
mepsz       5 non-null float64
mpid        5 non-null object
op_gap      5 non-null float64
formula     5 non-null object
dtypes: float64(12), int64(2), object(2)
memory usage: 840.0+ bytes
~~~
{: .output}

*   This is a `DataFrame`
*   Five rows named `'JVASP-XXXXX'`
*   Sixteen columns, most of which has two actual 64-bit floating point values.
    *   We will talk later about null values, which are used to represent missing observations.
*   Uses 840 bytes of memory.

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
Index(['epsx', 'epsy', 'epsz', 'fin_en', 'form_enp', 'gv', 'icsd', 'kp_leng',
       'kv', 'mbj_gap', 'mepsx', 'mepsy', 'mepsz', 'mpid', 'op_gap',
       'formula'],
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
jid      JVASP-11997 JVASP-12010 JVASP-12023 JVASP-12027 JVASP-12028
epsx         21.0673      6.3933      6.0838      7.0316      4.6738
epsy         29.1228      6.9466      6.0838      6.3127       4.746
epsz         17.6066      6.3796      6.5652      5.2274      4.7722
fin_en      -12.2422    -103.757     0.75676    -35.5855    -4.65386
form_enp       0.025      -2.086      -0.204      -1.768       -0.83
gv            19.993       52.42       5.947       37.12       9.047
icsd          609832      158256       28230       27393       65198
kp_leng           65          50          60          55          55
kv            34.556      75.067      17.478      54.633      16.378
mbj_gap       0.6495      2.4642      2.7025      2.2441      3.7113
mepsx        15.0619      5.2402       4.532      6.0366      3.6685
mepsy        14.9875      5.8492      4.5323       5.526      3.7637
mepsz        12.4788      5.3897      4.9101      4.6886      3.7977
mpid          mp-158   mp-510584   mp-567809   mp-570157   mp-570219
op_gap        0.0221      1.9202      1.2599      1.8723      2.3104
formula           As        MoO3         AgI       ZrBrN       InBr3
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
            epsx       epsy       epsz      fin_en  form_enp        gv  \
count   5.000000   5.000000   5.000000    5.000000  5.000000   5.00000
mean    9.049960  10.642380   8.110200  -31.096278 -0.972600  24.90540
std     6.773053  10.361935   5.362285   42.921358  0.932551  19.62964
min     4.673800   4.746000   4.772200 -103.756610 -2.086000   5.94700
25%     6.083800   6.083800   5.227400  -35.585506 -1.768000   9.04700
50%     6.393300   6.312700   6.379600  -12.242175 -0.830000  19.99300
75%     7.031600   6.946600   6.565200   -4.653860 -0.204000  37.12000
max    21.067300  29.122800  17.606600    0.756760  0.025000  52.42000

                icsd    kp_leng         kv   mbj_gap      mepsx      mepsy  \
count       5.000000   5.000000   5.000000  5.000000   5.000000   5.000000
mean   177781.800000  57.000000  39.622400  2.354320   6.907840   6.931740
std    247338.976031   5.700877  25.189198  1.106035   4.641301   4.578129
min     27393.000000  50.000000  16.378000  0.649500   3.668500   3.763700
25%     28230.000000  55.000000  17.478000  2.244100   4.532000   4.532300
50%     65198.000000  55.000000  34.556000  2.464200   5.240200   5.526000
75%    158256.000000  60.000000  54.633000  2.702500   6.036600   5.849200
max    609832.000000  65.000000  75.067000  3.711300  15.061900  14.987500

           mepsz    op_gap
count   5.000000  5.000000
mean    6.252980  1.476980
std     3.527928  0.895979
min     3.797700  0.022100
25%     4.688600  1.259900
50%     4.910100  1.872300
75%     5.389700  1.920200
max    12.478800  2.310400
~~~
{: .output}

*   Not particularly useful with just five records,
    but very helpful when there are thousands.

> ## Reading Other Data
>
> Read the data in `jarvis_all.csv`
> (which should be in the same directory as `jarvis_subset.csv`)
> into a variable called `data_all`
> and display its summary statistics.
>
> > ## Solution
> > To read in a CSV, we use `pandas.read_csv` and pass the filename `data/jarvis_all.csv` to it. We also once again pass the
> > column name `jid` to the parameter `index_col` in order to index by country:
> > ~~~
> > data_all = pandas.read_csv('data/jarvis_all.csv', index_col='jid')
> > data_all.describe()
> > ~~~
> >{: .python}
> {: .solution}
{: .challenge}



> ## Inspecting Data.
>
> After reading the Jarvis data,
> use `help(data_all.head)` and `help(data_all.tail)`
> to find out what `DataFrame.head` and `DataFrame.tail` do.
>
> 1.  What method call will display the first three rows of this data?
> 2.  What method call will display the last three columns of this data?
>     (Hint: you may need to change your view of the data.)
>
> > ## Solution
> > 1. We can check out the first five rows of `data_all` by executing `data_all.head()` (allowing us to view the head
> > of the DataFrame). We can specify the number of rows we wish to see by specifying the parameter `n` in our call
> > to `data_all.head()`. To view the first three rows, execute:
> >
> > ~~~
> > data_all.head(n=3)
> > ~~~
> >{: .python}
> > 2. To check out the last three rows of `data_all`, we would use the command, `data_all.tail(n=3)`,
> > analogous to `head()` used above. However, here we want to look at the last three columns so we need
> > to change our view and then use `tail()`. To do so, we create a new DataFrame in which rows and
> > columns are switched
> >
> > ~~~
> > data_all_flipped = data_all.T
> > ~~~
> >{: .python}
> >
> > We can then view the last three columns of `data_all` by viewing the last three rows of `data_all_flipped`:
> > ~~~
> > data_all_flipped.tail(n=3)
> > ~~~
> >{: .python}
> >
> > Note: we could have done the above in a single line of code by 'chaining' the commands:
> > ~~~
> > data_all.T.tail(n=3)
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
> > In order to write the DataFrame `data_all` to a file called `processed.csv`, execute the following command:
> > ~~~
> > data_all.to_csv('processed.csv')
> > ~~~
> >{: .python}
> > For help on `to_csv`, you could execute, for example,
> > ~~~
> > help(data_all.to_csv)
> > ~~~
> >{: .python}
> > Note that `help(to_csv)` throws an error! This is a subtlety and is due to the fact that `to_csv` is NOT a function in
> > and of itself and the actual call is `data_all.to_csv`.
> >
> {: .solution}
{: .challenge}
