-- Load input file from HDFS
inputFile = LOAD '/root/file01.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE group, COUNT(words);

--To remove old output folder
rmf /root/PigOutput1';
-- Store the result in HDFS
STORE cntd INTO '/root/PigOutput1';
