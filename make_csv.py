# Raw data is at: https://ndownloader.figshare.com/files/12468083
# This should be saved into "data.json"
# This translates that data into a CSV file.
# This script uses this Nix environment: https://github.com/usnistgov/jarvis/blob/fb0b6c4a2d6b85f692db44a5dfcf8962e4945549/default.nix
# Also toolz

from monty.serialization import loadfn,MontyDecoder
from toolz.curried import map, assoc, pipe
import pandas

columns = ['encut', 'epsx', 'fin_en', 'form_enp', 'gv', 'icsd', 'jid', 'kp_leng', 'kv', 'mbj_gap', 'mepsx', 'mpid', 'op_gap', 'formula']

def make_csv(columns, number, size, filename):
    return pipe(
        'data.json',
        lambda x: loadfn(x, cls=MontyDecoder)[:number],
        map(
            lambda x: assoc(
                x,
                key='formula',
                value=x['final_str'].composition.reduced_formula
            ),
        ),
        list,
        lambda x: pandas.DataFrame(x),
        lambda x: x[columns],
        lambda x: x.to_csv('tmp.csv', index=False),
        lambda _: pandas.read_csv('tmp.csv', na_values=['None', 'na']),
        lambda x: x.dropna().reset_index(drop=True).ix[:size],
        lambda x: x.to_csv(filename, index=False)
    )

columns = ['epsx',
         'epsy',
         'epsz',
         'fin_en',
         'form_enp',
         'gv',
         'icsd',
         'kp_leng',
         'kv',
         'mbj_gap',
         'mepsx',
         'mepsy',
         'mepsz',
         'mpid',
         'op_gap',
         'jid',
         'formula']

make_csv(
    columns,
    10000,
    2000,
    'jarvis_all.csv'
)

make_csv(
    columns,
    10000,
    4,
    'jarvis_subset.csv'
)
