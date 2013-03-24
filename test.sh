#!/bin/bash
# $1 = binary to test
# $2 = tests dir
# $3 = test number

binary="$1"
test_dir="$2"
test_number="$3"
test_in="${test_dir}/in${test_number}.txt"
test_out="${test_dir}/out${test_number}.txt"
test_result="out_$$.txt"

if [ ! -f "${binary}" ]
then
    echo "Seems the binary '${binary}' doesn't exist."
    exit 1
fi
if [ ! -x "${binary}" ]
then
    echo "Seems the binary '${binary}' is not executable."
    exit 1
fi
if [ ! -d "${test_dir}" ]
then
    echo "Seems the directory '${test_dir}' doesn't exist."
    exit 1
fi
if [ -z "${test_number}" ]
then
    echo "Seems the test number was not given."
    exit 1
fi
if [ ! -f "${test_in}" ]
then
    echo "Seems the test '${test_number}' doesn't have an input file."
    exit 1
fi
if [ ! -f "${test_out}" ]
then
    echo "Seems the '${test_number}' doesn't have an output file."
    exit 1
fi


"${binary}" < "${test_in}" | tee "${test_result}"
diff -B --suppress-common-lines "${test_result}" "${test_out}"
ok=$?
if [ "${ok}" = "0" ]
then
    echo "
****************** REUSSITE DU TEST"
else
    echo "
****************** ECHEC DU TEST"
fi

rm "${test_result}"
exit ${ok}

