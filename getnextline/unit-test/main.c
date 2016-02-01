/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tfleming <tfleming@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/11/13 11:52:59 by tfleming          #+#    #+#             */
/*   Updated: 2014/11/25 23:08:07 by tfleming         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

char				*get_next_line(int const fd);

#define TF_DEBUG		0

void			test(char *filename)
{
	int		fd;
	int		outfd;
	char	*line;

	if (TF_DEBUG)
	{
		printf("===========================================================\n");
		printf("filename = %s\n", filename);
	}
	fd = open(filename, O_RDONLY);
	outfd = open("this_out.txt", O_WRONLY | O_TRUNC);
	while ((line = get_next_line(fd)) != NULL)
	{
		if (TF_DEBUG) printf("returned = \t|%s|\n", line);
		dprintf(outfd, "%s\n", line);
		free(line);
	}
	if (TF_DEBUG) printf("last = \t\t|%s|\n", line);
	if (line)
	{
		dprintf(outfd, "%s", line);
		free(line);
	}
	line = get_next_line(fd);
	if (line != NULL) printf("repeated calls failing\n");
	close(outfd);
	close(fd);
	if (TF_DEBUG) printf("=================================================\n");
}

int				main(int argc, char **argv)
{
	char		*fake_line;

	if (argc != 2)
	{
		if (argc == 3)
		{
		  if ((fake_line = get_next_line(42))  == NULL)
				printf("done testing fake fd\n");
			else
				printf("ERROR: did not pass fake fd test\n");
		}
		else
			printf("incorrect arguments to testing program=====\n");
		return (1);
	}
	test(argv[1]);
	return (0);
}
