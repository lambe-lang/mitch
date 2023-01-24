# Mitch

MVP for the compilation of an extended lambda-calculus to Michelson.

## Compilation stage

Things to be done in order to a have a complete POC:

- [X] Function application (not partial one)
- [X] Sum data covering Inl, Inr and Case
- [X] Product data covering Pair, First and Second
- [X] Code Optimisation
- [ ] Recursive function
- [ ] Partial evaluation
- [ ] Type decoration
- [ ] Recursive types

## Compilation Sketch 

### Transpilation

The transpilation takes a lambda-caluculus with recursion, sum and product data and 
produces the corresponding Michelson code.

### Expansion

Expansion is a denormalisation operation building a source code based on a tree from
a one which is a DAG.

### Optimisation

This stage provides an optimised version of the initial Michelson source code. This 
optimisation is done thanks to a symbolique evaluation. 

### Simplification

The simplification is process which detect some pattern. This is a system based on
a set of rewriting rules.

### Normalisation

This last stages revert the expansion process turing a tree base source code to a DAG
in order to reduce the size of the souce code finally.

## Tezos related projects

- [Michelson: the language of Smart Contracts in Tezos](https://tezos.gitlab.io/active/michelson.html)
- [Michelson optimizer](https://www.dailambda.jp/optz/)

# License

MIT License

Copyright (c) 2023 Didier Plaindoux

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
