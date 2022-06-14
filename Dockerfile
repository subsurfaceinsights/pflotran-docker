#build pflotran
FROM ubuntu:20.04 as pflotran-build-env
WORKDIR /build
COPY ./ubuntu-pflotran-build-deps.sh .
RUN ./ubuntu-pflotran-build-deps.sh

FROM pflotran-build-env as pflotran-build
COPY ./build-petsc.sh .

ARG PETSC_VERSION=v3.16.2
RUN ./build-petsc.sh $PETSC_VERSION
COPY ./pflotran-patches pflotran-patches
COPY ./build-pflotran.sh .

ARG PFLOTRAN_VERSION=v4.0
RUN ./build-pflotran.sh $PFLOTRAN_VERSION

FROM ubuntu:20.04 as pflotran
COPY ./ubuntu-pflotran-run-deps.sh .
RUN ./ubuntu-pflotran-run-deps.sh
COPY --from=pflotran-build /build/pflotran/src/pflotran /bin
COPY --from=pflotran-build /build/petsc/arch-linux2-c-opt/bin /bin
COPY --from=pflotran-build /build/petsc/arch-linux2-c-opt/lib /lib
COPY docker-entrypoint.sh .
WORKDIR /data
ENTRYPOINT [ "../docker-entrypoint.sh" ]
