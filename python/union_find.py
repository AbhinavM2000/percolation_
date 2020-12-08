import random, time
startTime = time.time()

def initLattice(dimension):
    matrix = []
    matrix.append([1]*dimension)
    for i in range(dimension-2):
        row = [0]*(dimension)
        matrix.append(row)
    matrix.append([1]*dimension)
    return matrix

def printMatrix(matrix):
    dimension = len(matrix)
    for i in range(dimension):
        for j in range(dimension):
            print(matrix[i][j], end = '  ')
        print('\n')


def fillRandomSites(matrix, idMatrix, listOfSets):
    dimension = len(matrix)
    indexList = range(dimension)
    row = random.choice(indexList)
    col = random.choice(indexList)

    while matrix[row][col]!=0:
        row = random.choice(indexList)
        col = random.choice(indexList)

    matrix[row][col] = 1
    union(matrix, idMatrix, listOfSets, row, col)

def initLatticeId(dimension):
    idMatrix = []
    idMatrix.append([0]*dimension)
    for i in range(dimension-2):
        row = []
        for j in range(dimension):
            row.append(dimension**2 + j + i*(dimension))
        idMatrix.append(row)
    idMatrix.append([1]*dimension)
    return idMatrix

def initListOfSets(dimension):
    listOfSets = []
    for i in [0,dimension-1]:
        row = []
        for j in range(dimension):
            row.append((i,j))
        listOfSets.append(row)
    return listOfSets

def glueClusters(idMatrix, listOfSets, id1, id2):
    if id1!=id2:
        if len(listOfSets[id1])<len(listOfSets[id2]):
            for toup in listOfSets[id1]:
                idMatrix[toup[0]][toup[1]] = id2
            set1 = set(listOfSets[id1])
            set2 = set(listOfSets[id2])
            union = set1.union(set2)
            combination = list(union)
            listOfSets[id2] = combination
            listOfSets[id1] = None
            return id2

        else:
            for toup in listOfSets[id2]:
                idMatrix[toup[0]][toup[1]] = id1
            set1 = set(listOfSets[id1])
            set2 = set(listOfSets[id2])
            union = set1.union(set2)
            combination = list(union)
            listOfSets[id1] = combination
            listOfSets[id2] = None
            return id1

    return id2


def union(matrix, idMatrix, listOfSets, row, col):
    dimension = len(matrix)
    if matrix[row][col] == 1:
        id = len(listOfSets)
        idMatrix[row][col] = id
        listOfSets.append([(row, col)])

        if row<dimension-1 and matrix[row+1][col] == 1:
            id2 = idMatrix[row+1][col]
            id = glueClusters(idMatrix, listOfSets, id, id2)


        if row>0 and matrix[row-1][col] == 1:
            id2 = idMatrix[row-1][col]
            id = glueClusters(idMatrix, listOfSets, id, id2)


        if col<dimension-1 and matrix[row][col+1] == 1:
            id2 = idMatrix[row][col+1]
            id = glueClusters(idMatrix, listOfSets, id, id2)


        if col>0 and matrix[row][col-1] == 1:
            id2 = idMatrix[row][col-1]
            id = glueClusters(idMatrix, listOfSets, id, id2)



def find(matrix, idMatrix, row1, col1, row2, col2):
    if matrix[row1][col1] == 1 and matrix[row2][col2] == 1:
        id1 = idMatrix[row1][col1]
        id2 = idMatrix[row2][col2]
        if id1==id2:
            return True

    return False

def findRowsConnected(matrix, id, row1, row2):
    for col1 in range(dimension):
        for col2 in range(dimension):
            if id[row1][col1] == id[row2][col2]:
                return True
    return False


dimension = int(input('enter the size\n'))
#dimension = 10
matrix = initLattice(dimension)
idMatrix  = initLatticeId(dimension)
listOfSets = initListOfSets(dimension)
count = 0

while not findRowsConnected(matrix, idMatrix, 0, dimension-1):
    fillRandomSites(matrix, idMatrix, listOfSets)
    count+=1
#printMatrix(matrix)
#print(count)
endTime = time.time()
print('percolation threshold for ', dimension, '*', dimension, 'lattice',  count/(dimension**2))
print('time taken(in seconds): ', endTime-startTime)
