#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef char vector_data;

//STRUCT PADDING IS IMPORTANT, MESSING UP THE ORDER OF THESE WILL ALSO MAKE THE ASM FAIL
//BE VERY WARY
typedef struct {
  vector_data *data; //8 bytes (on x86-64)
  uint8_t width; //1 byte
  uint8_t height; //1 byte
  //hidden unseen demon space of 6 bytes 
}vector;

void print_vector(vector *vec);

void print_vector(vector *vec){
  for(uint8_t j = 0; j < vec->height; j++){
    uint8_t offset = j * vec->width; //precompute the offset each time. Probably would be done by compiler anyway whatever
    for(uint8_t i = 0; i < vec->width; i++){
      printf("%i ", vec->data[offset+i]);
    }    
    putchar('\n');
  }  
  fflush(stdout);
}
