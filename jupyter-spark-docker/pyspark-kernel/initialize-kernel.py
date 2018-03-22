# Configure the necessary Spark environment
import os
import sys

spark_home = os.environ.get('SPARK_HOME', None)
sys.path.insert(0, spark_home + "/python")

# Add the py4j to the path.
# You may need to change the version number to match your install
sys.path.insert(0, os.path.join(spark_home, 'python/lib/py4j-0.10.4-src.zip'))


# Initialize PySpark to predefine the SparkContext variable 'sc'
# ------------------------------------------------------------------------
shell_file = os.path.join(spark_home, 'python/pyspark/shell.py')
with open(os.path.join(shell_file)) as f:
    code = compile(f.read(), shell_file, 'exec')
    exec(code)