#! @Chunk HerrPundFrauS

LoadPackage( "FinSetsForCAP" );

#! @Example
AsUndBs := FinSet( Cartesian( [2..50], [2..50] ) );;
Sums1 := FinSet( ListOp( AsUndBs, ab->ab[1]+ab[2] ) );;
Length( Sums1 );
#! 97
Products1 := FinSet( ListOp( AsUndBs, ab->ab[1]*ab[2] ) );;
Length( Products1 );
#! 784
divs := function(n)
> local S, i;
> S :=[];
> i:=2;
> while i < n/2+1 do
> if n mod i = 0 then
> Add( S, i );
> fi;
> i := i+1;
> od;
> return Set(S);
> end;
#! function( n ) ... end
Products2 := FilteredOp( Products1, n->Length( divs(n) )>2 );;
Length( Products2 );
#! 660
prods := function( n )
> local S,k;
> S := [];
> k := 2;
> while k < n/2+1 do
> Add( S, k*(n-k) );
> k := k+1;
> od;
> return Set( S );
> end;
#! function( n ) ... end
Sums2 := FilteredOp( Sums1, n->IsWellDefined( 
EmbeddingOfFinSets( FinSet( prods(n) ), Products2 ) ));;
Length( Sums2 );
#! 11
sums := function( n )
> local S, d;
> S := [];
> for d in divs(n) do
> Add( S, d+n/d );
> od;
> return Set(S);
> end;
#! function( n ) ... end
Products3 := FilteredOp( Products2, n-> 
IsTerminal( ImageObject( 
ProjectionInFactorOfFiberProduct(
[ EmbeddingOfFinSets( FinSet( sums(n) ), Sums2 ),
IdentityMorphism( Sums2 ) ], 1 ) ) ) );;
Length( Products3 );
#! 102
Sums3 := FilteredOp( Sums2, n->IsTerminal(
ImageObject( ProjectionInFactorOfFiberProduct(
[EmbeddingOfFinSets( FinSet( prods(n) ), Products3 ),
IdentityMorphism( Products3 ) ], 1 ) ) ) );;
Length( Sums3 );
#! 1
Display( Sums3 );
#! [ 17 ]
Products4 :=ImageObject(ProjectionInFactorOfFiberProduct(
[EmbeddingOfFinSets( FinSet( Flat(ListOp(
Sums3,n->prods(n)))), Products3 ), IdentityMorphism(
Products3 )],1) );;
Length( Products4 );
#! 1
Display( Products4 );
#! [ 52 ]
divs( 52 );
#! [ 2, 4, 13, 26 ];
4+13 = 17;
#! true
4*13 = 52;
#! true
Filtered( Partitions( 17 ), p-> Length(p)=2
and Product( p ) = 52 );
#! [ [ 13, 4 ] ]
#! @EndExample
