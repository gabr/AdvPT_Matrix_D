/**
   Arkadiusz Gabrys
   arkadiusz.gabrys@fau.de
   qe83mepi

   AdvPTEx
*/

import std.stdio;
import std.conv;

class Matrix
{
    private:
        size_t rows;
        size_t columns;
        double[][] matrix;

    public:
        this(size_t r, size_t c)
        {
            rows = r;
            columns = c;

            matrix = new double[][](r, c);

            for (int i = 0; i < r; i++)
                for (int j = 0; j < c; j++)
                    matrix[i][j] = 0;
        }

        size_t getRowsCount() { return rows; };
        size_t getColumnsCount() { return columns; };

        double opIndex(size_t r, size_t c) { return matrix[r][c]; }
        Matrix opIndexAssign(double value, size_t r, size_t c) { matrix[r][c] = value; return this; }

        Matrix opMul(Matrix m)
        {
            if (columns != m.getRowsCount())
                throw new Exception("Matrices can not be multiplied. Number of collumns of the first matrix must be equal to number of rows of the second one!");

            // create result matrix
            Matrix result = new Matrix(rows, m.getColumnsCount());

            for (size_t r = 0; r < result.getRowsCount(); r++)
                for (size_t c = 0; c < result.getColumnsCount(); c++)
                    for (size_t rc = 0; rc < columns; rc++)
                        result.matrix[r][c] += matrix[r][rc] * m.matrix[rc][c];

            return result;
        }

};


int getDimension(string prompt)
{
    int result;

    do
    {
    write(prompt);
    readf(" %s", &result);

    if (result <= 0)
        writeln(" ! Error: dimension can't be zero or negative!");
    else
        break;

    } while(true);


    return result;
}

void fillMatrix(Matrix matrix)
{
    double tmp;

    for (size_t r = 0; r < matrix.getRowsCount(); r++)
    {
        for (size_t c = 0; c < matrix.getColumnsCount(); c++)
        {
            write("m[", r, ",", c, "]: ");
            readf(" %s",&tmp);
            matrix[r, c] = tmp;
        }
        writeln();
    }
}

void writeMatrix(Matrix matrix)
{
    for (size_t r = 0; r < matrix.getRowsCount(); r++)
    {
        for (size_t c = 0; c < matrix.getColumnsCount(); c++)
            write(matrix[r,c], " ");
        writeln();
    }
}

int main()
{
    int s1, s2, s3;

    s1 = getDimension("s1: ");
    s2 = getDimension("s2: ");
    s3 = getDimension("s3: ");
    
    Matrix m1 = new Matrix(s1, s2);
    Matrix m2 = new Matrix(s2, s3);

    writeln();
    writeln("m1:");
    fillMatrix(m1);

    writeln("m2:");
    fillMatrix(m2);

    try
    {
        Matrix m3 = m1 * m2;
        writeMatrix(m3);
    }
    catch (Exception e)
    {
        writeln(e.msg);
        return 1;
    }

    return 0;
}
