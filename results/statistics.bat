rm *.csv
rm no_csp/*.csv

mkdir no_csp

:: copy result files to preprocessing directories
mv ../*no_csp.csv ./no_csp
mv ../channel_diff_feats.csv ./no_csp
mv ../*.csv .

:: compute statistics from no-CSP result files
python parse_person.py --nopts --sep=; --outfile=output.csv ./no_csp

:: compute statistics for CSP result files
python parse_person.py --nopts --sep=; --outfile=output.csv .
