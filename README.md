# nestfsss
Non-equilibrium superconducting thin film steady-state simulations

This repository contains MATLAB code used to solve for steady-state solutions to the Chang & Scalapino equations.

## Theory

Full theoretical details and derivations are available in (PhD thesis):  
Guruswamy, T. (2018) "Nonequilibrium behaviour and quasiparticle heating in thin film superconducting microwave resonators". [doi:10.17863/CAM.24510](https://doi.org/10.17863/CAM.24510).

Other relevant references:  
[D J Goldie and S Withington 2013 Supercond. Sci. Technol. 26 015004](http://dx.doi.org/10.1088/0953-2048/26/1/015004)  
[T Guruswamy et al 2014 Supercond. Sci. Technol. 27 055012](http://dx.doi.org/10.1088/0953-2048/27/5/055012)  
[T Guruswamy et al 2015 Supercond. Sci. Technol. 28 054002](http://dx.doi.org/10.1088/0953-2048/28/5/054002)  

## Installation

Add the top-level directory to your MATLAB pathdef. Most recently tested with MATLAB R2022a.

## Operation

* Instantiate a `Superconductor` object
  * contains material parameters as well as the arrays representing energy, quasiparticle distribution, and phonon distribution
  * preconfigured materials are available: `Sc_Aluminum`, `Sc_Niobium`, etc.
* Instantiate a `ThinFilm` object around the `Superconductor`
  * contains parameters defining signal (pair-breaking photons), probe (microwave/readout photons), and phonon injection
* Instantiate an Iterator object around the ThinFilm
  * contains parameters related to the solution convergence, number of iterations, etc.
* Run methods of the Iterator object to solve for the steady-state solution given the parameters set.
  * `it.main_iteration()` returns a new object with (hopefully) converged distributions, available via the internal Superconductor object.
  * `it.with_without_signal()` returns two objects, with solutions with the phonon and signal terms disabled, and with the phonon and signal terms enabled.

See `simple_test.m` for an example which calculates and then plots $f(E)$.

## Convergence and solution validity notes

* Solutions will fail to converge:
  * if the absorbed power is very high
  * if the phonon trapping factor is very high
  * if the starting distribution is very strange.
* Many assumptions detailed in the theory references above
	* only considers redistribution of quasiparticles, not changes in the density of states[^1]
	* assume 3-D, clean-limit, BCS superconductors

[^1]:	Semenov, A. V., Devyatov, I. A., de Visser, P. J. & Klapwijk, T. M. Coherent excited states in superconductors due to a microwave field. Physical Review Letters 117, 047002 (2016).

