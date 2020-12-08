#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>

typedef struct Position{
  int row;
  int col;
} struct_position;

typedef struct Stack{
  int top;
  int capacity;
  struct_position** array;
} struct_stack;

struct_stack* Create_Stack(int capacity){
  struct_stack* stack;
  stack = (struct_stack*)malloc(sizeof(struct_stack*));
  stack->top = -1;
  stack->capacity = capacity;
  stack->array = (struct_position**)malloc(sizeof(struct_position*)*capacity);
  return stack;
}

int isFull(struct_stack* stack){
  if(stack->top == stack->capacity -1){return 1;}
  else return 0;
}

int isEmpty(struct_stack* stack){
  if(stack->top == -1){return 1;}
  else return 0;
}

void push(struct_stack* stack, struct_position* position){
  if(isFull(stack)){return;}
  stack->array[stack->top +1] = position;
  stack->top++;
  return;
}

struct_position* pop(struct_stack* stack){
  if(isEmpty(stack)){return NULL;}
  struct_position* req_pos = (struct_position*)malloc(sizeof(struct_position));
  req_pos = stack->array[stack->top];
  stack->top--;
  return req_pos;
}

struct_position* peek(struct_stack* stack){
  if(isEmpty(stack)){return NULL;}
  return stack->array[stack->top];
}

void Print_stack(struct_stack* stack){
  printf("%s","stack-");
  if(isEmpty(stack)){
    printf("%s\n", "empty");
    return;
  }
  for(int i = 0; i<=stack->top; i++){
    printf("(%d, %d)", stack->array[i]->row, stack->array[i]->col);
  }
  printf("%s\n", "-stack\n");
}

int Num_Path(int** matrix, int dimension){
  int num_path = 0;
  struct_stack* stack = Create_Stack(dimension*dimension);
  for(int i = 0; i<dimension; i++){
    if(matrix[0][dimension-1-i] == 1){
      struct_position* position = (struct_position*)malloc(sizeof(struct_position));
      position->row = 0;
      position->col = dimension-1-i;
      push(stack, position);
    }
  }


  if(isEmpty(stack)){return 0;}

  while(!isEmpty(stack)){
    struct_position* position = (struct_position*)malloc(sizeof(struct_position));
    position = pop(stack);


    if(position->row == dimension-1){num_path++;}

    else if(position->col == 0){
      if(matrix[position->row +1][position->col+1] == 1){
        struct_position* add_position_1 = (struct_position*)malloc(sizeof(struct_position));
        add_position_1->row = position->row + 1;
        add_position_1->col = position->col + 1;
        push(stack, add_position_1);
      }
      if(matrix[position->row +1][position->col] == 1){
        struct_position* add_position_2 = (struct_position*)malloc(sizeof(struct_position));
        add_position_2->row = position->row + 1;
        add_position_2->col = position->col;
        push(stack, add_position_2);
      }
    }

    else if(position->col == dimension-1){
      if(matrix[position->row +1][position->col] == 1){
        struct_position* add_position_1 = (struct_position*)malloc(sizeof(struct_position));
        add_position_1->row = position->row + 1;
        add_position_1->col = position->col;
        push(stack, add_position_1);
      }
      if(matrix[position->row +1][position->col -1] == 1){
        struct_position* add_position_2 = (struct_position*)malloc(sizeof(struct_position));
        add_position_2->row = position->row + 1;
        add_position_2->col = position->col - 1;
        push(stack, add_position_2);
      }
    }

    else {
      if(matrix[position->row +1][position->col+1] == 1){
        struct_position* add_position_1 = (struct_position*)malloc(sizeof(struct_position));
        add_position_1->row = position->row + 1;
        add_position_1->col = position->col + 1;
        push(stack, add_position_1);
      }
      if(matrix[position->row +1][position->col] == 1){
        struct_position* add_position_2 = (struct_position*)malloc(sizeof(struct_position));
        add_position_2->row = position->row + 1;
        add_position_2->col = position->col;
        push(stack, add_position_2);
      }
      if(matrix[position->row +1][position->col -1] == 1){
        struct_position* add_position_3 = (struct_position*)malloc(sizeof(struct_position));
        add_position_3->row = position->row + 1;
        add_position_3->col = position->col - 1;
        push(stack, add_position_3);
    }
  }
  }
  return num_path;
}


int print_1(int* arr, int dimension){
  for(int i = 0; i<dimension; i++){
    printf("%d ", arr[i]);
  }
  return 0;
}

int print_2(int** arr, int dimension){
  printf("%s\n", "---the matrix is---");
  for(int i = 0; i<dimension; i++){
    for(int j = 0; j<dimension; j++){
      printf("%d ",arr[i][j]);
    }
    printf("\n");
  }
  return 0;
}

double Random(){
  double a;
  double b = modf(((double)rand())/10, &a);
  return b;
}


int** init(int* arr, int dimension){
  int** mat;
  mat = (int**)malloc(sizeof(int*)*dimension);
  for(int i = 0; i<dimension; i++){
    mat[i] = (int*)malloc(sizeof(int)*dimension);
  }
  int l = 0;
  for(int i = 0;i<dimension; i++){
    for(int j = 0; j<dimension; j++){
      mat[i][j]=arr[l];
      l++;
    }
  }
  return mat;
}


int** Make_Matrix(int dimension, double p_1){
  int* inp = (int*)malloc(sizeof(int)*(dimension*dimension));
  srand(time(0));
  for(int i = 0; i<dimension*dimension; i++){
    double c = Random();
    if(c < p_1){inp[i] = 0;}
    else{inp[i] = 1;}
  }
  int** mat = init(inp, dimension);
  return mat;
}


int main(){
  int dimension;
  double p_1;
  printf("%s\n", "Enter the dimension");
  scanf("%d", &dimension);
  printf("%s\n", "Enter p_1 (probability of 0)");
  scanf("%lf", &p_1);
  int** mat = Make_Matrix(dimension, p_1);
  print_2(mat, dimension);
  int n;
  n = Num_Path(mat, dimension);
  printf("number of paths is---------*drum roll*\n****%d****", n);
  return 0;
}
